//
//  FirstSignUpVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 1.03.2024.
//

import UIKit

class FirstSignUpVC: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = GCTitleLabel(textAlignment: .center, fontSize: 24)
    let bodyLabel = GCBodyLabel(textAlignment: .center, fontSize: 14)
    let nameTextFieldLabel = GCFieldTitleLabel(text: "Adınız ve Soyadınız")
    let nameTextField = GCAuthTextField()
    let phoneNumberTextFieldLabel = GCFieldTitleLabel(text: "Telefon Numaranız")
    let phoneNumberTextField = GCAuthTextField()
    let nextButton = GCButton(type: .filled(), text: "Sonraki")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureImageView()
        configureTitleLabel()
        configureBodyLabel()
        configureNameTextField()
        configurePhoneNumberTextField()
        configureNextButton()
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.gamecenterLogo
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = "Kişisel Bilgiler"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureBodyLabel() {
        view.addSubview(bodyLabel)
        
        bodyLabel.text = "Öncelikle aramıza şimdiden hoşgeldiniz. Kişisel bilgiler ile başlayalım. Diğer kullanıcılar ile alışverişte iki taraflı güveni sağlamak için kimlik doğrulaması da gerekecektir. Bu sebeple bilgilerini doğru girmelisin."
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureNameTextField() {
        view.addSubviews(nameTextFieldLabel, nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextFieldLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20),
            nameTextFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextFieldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameTextFieldLabel.heightAnchor.constraint(equalToConstant: 15),
            
            nameTextField.topAnchor.constraint(equalTo: nameTextFieldLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePhoneNumberTextField() {
        view.addSubviews(phoneNumberTextFieldLabel, phoneNumberTextField)
        
        NSLayoutConstraint.activate([
            phoneNumberTextFieldLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            phoneNumberTextFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phoneNumberTextFieldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            phoneNumberTextFieldLabel.heightAnchor.constraint(equalToConstant: 15),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberTextFieldLabel.bottomAnchor, constant: 10),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        nextButton.configuration?.cornerStyle = .capsule
        nextButton.tintColor = .systemGreen
        nextButton.configuration?.baseForegroundColor = .black
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Button Actions
    
    @objc private func nextButtonTouched() {
        let vc = SecondSignUpVC()
        vc.fullname = nameTextField.text
        vc.phoneNumber = phoneNumberTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
}
