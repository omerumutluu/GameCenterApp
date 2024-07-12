//
//  AddAdvertisementVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 26.02.2024.
//

import UIKit

class AddAdvertisementVC: GCDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let titleLabel = GCFieldTitleLabel(text: "İlan Başlığı")
    let titleTextField = GCAuthTextField()
    let gamePickerLabel = GCFieldTitleLabel(text: "Oyun Seçiniz")
    let gamePicker = GCButton(type: .borderless())
    let deliveryTimeLabel = GCFieldTitleLabel(text: "Maksimum Teslimat Zamanı")
    var maximumDeliveryTimePicker: UISegmentedControl!
    let descriptionLabel = GCFieldTitleLabel(text: "İlan Açıklaması")
    let descriptionTextView = UITextView()
    let priceLabel = GCFieldTitleLabel(text: "İlan Fiyatı")
    let priceTextField = GCAuthTextField()
    let imageView = UIImageView()
    
    let maximumDeliveryTimes = ["1 saat", "2 saat", "5 saat", "12 saat", "24 saat"]
    var selectedGame: Game? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "İlan Ekleme"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ekle", style: .done, target: self, action: #selector(addButtonTouched))
        let tapRecognizer = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapRecognizer)
        
        configureScrollView()
        configureTitleTextField()
        configureGamePicker()
        configureMaximumDeliveryTimePicker()
        configureDescriptionTextField()
        configurePriceTextField()
        configureImageView()
    }
    
    //MARK: - Actions -
    
    @objc private func didImageTouched() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func addButtonTouched() {
        self.showLoadingView()
        let result = isFieldsValid()
        
        switch result {
        case .success():
            StorageManager.shared.uploadImage(image: imageView.image!.jpegData(compressionQuality: 0.5)!, folder: FirestoreCollections.Advertisements) { imageURL in
                guard let imageURL else {
                    self.presentGCAlert(title: "Hata", message: GCError.uploadImageError.rawValue, buttonTitle: "Tamam")
                    return
                }
                let advertisement = Advertisement(
                    id: UUID().uuidString,
                    title: self.titleTextField.text!,
                    gameId: self.selectedGame!.id,
                    userId: AuthManager.shared.currentUser!.id,
                    description: self.descriptionTextView.text,
                    imageURL: imageURL,
                    maximumDeliveryTime: self.maximumDeliveryTimes[self.maximumDeliveryTimePicker.selectedSegmentIndex],
                    price: Double(self.priceTextField.text!) ?? 0,
                    viewCount: 0,
                    createdAt: Date(),
                    isActive: true
                )
                
                APICaller.shared.add(advertisement: advertisement) { error in
                    guard error == nil else {
                        self.presentGCAlert(title: "Hata", message: error!.rawValue, buttonTitle: "Tamam")
                        return
                    }
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            
        case .failure(let error):
            self.presentGCAlert(title: "Doğrulama Hatası", message: error.rawValue, buttonTitle: "Tamam")
        }
    }
    
    private func isFieldsValid() -> Result<Void, GCValidationError> {
        if titleTextField.text!.count < 3 {
            return .failure(.advertisementTitleLengthError)
        }
        return .success(())
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800)
        ])
    }
    
    private func configureTitleTextField() {
        contentView.addSubviews(titleLabel, titleTextField)
        
        titleTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        titleTextField.leftViewMode = .always
        titleTextField.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureGamePicker() {
        contentView.addSubviews(gamePickerLabel, gamePicker)
        
        gamePicker.tintColor = .label
        
        var gameChildren = [UIMenuElement]()
        
        APICaller.shared.getGames { result in
            switch result {
            case .success(let games):
                gameChildren.append(UIAction(title: "Oyun Seçiniz", handler: { _ in
                    self.selectedGame = nil
                }))
                for game in games {
                    gameChildren.append(UIAction(title: game.name, handler: { action in
                        self.selectedGame = game
                    }))
                }
                self.gamePicker.menu = UIMenu(children: gameChildren)
                self.gamePicker.showsMenuAsPrimaryAction = true
                self.gamePicker.changesSelectionAsPrimaryAction = true
                
            case .failure(let error): 
                self.presentGCAlert(title: "Hata", message: error.rawValue, buttonTitle: "Tamam")
            }
        }
        
        NSLayoutConstraint.activate([
            gamePicker.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            gamePicker.widthAnchor.constraint(equalToConstant: 220),
            gamePicker.heightAnchor.constraint(equalToConstant: 35),
            gamePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            gamePickerLabel.centerYAnchor.constraint(equalTo: gamePicker.centerYAnchor),
            gamePickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            gamePickerLabel.trailingAnchor.constraint(equalTo: gamePicker.leadingAnchor, constant: -20),
            gamePickerLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func configureMaximumDeliveryTimePicker() {
        maximumDeliveryTimePicker = UISegmentedControl(items: maximumDeliveryTimes)
        maximumDeliveryTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews(deliveryTimeLabel, maximumDeliveryTimePicker)
        
        NSLayoutConstraint.activate([
            deliveryTimeLabel.topAnchor.constraint(equalTo: gamePicker.bottomAnchor, constant: 30),
            deliveryTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            deliveryTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            deliveryTimeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            maximumDeliveryTimePicker.topAnchor.constraint(equalTo: deliveryTimeLabel.bottomAnchor, constant: 10),
            maximumDeliveryTimePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            maximumDeliveryTimePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            maximumDeliveryTimePicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureDescriptionTextField() {
        contentView.addSubviews(descriptionLabel, descriptionTextView)
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isEditable = true
        descriptionTextView.backgroundColor = .secondarySystemBackground
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: maximumDeliveryTimePicker.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 15),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configurePriceTextField() {
        contentView.addSubviews(priceLabel, priceTextField)
        
        priceTextField.keyboardType = .decimalPad
        
        priceTextField.rightViewMode = .always
        let img = UIImageView(frame: CGRect(x: -2, y: 9.5, width: 16, height: 16))
        img.image = UIImage(systemName: "turkishlirasign")
        img.tintColor = .secondaryLabel
        
        let vw = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 35))
        vw.addSubview(img)
        priceTextField.rightView = vw
        
        NSLayoutConstraint.activate([
            priceTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30),
            priceTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceTextField.widthAnchor.constraint(equalToConstant: 150),
            priceTextField.heightAnchor.constraint(equalToConstant: 35),
            
            priceLabel.centerYAnchor.constraint(equalTo: priceTextField.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            priceLabel.trailingAnchor.constraint(equalTo: priceTextField.leadingAnchor, constant: -20),
            priceLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureImageView() {
        contentView.addSubview(imageView)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didImageTouched))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage.touchToSelect
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(tapGR)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}

extension AddAdvertisementVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("selamlar")
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
}
