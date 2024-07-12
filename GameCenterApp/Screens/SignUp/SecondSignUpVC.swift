//
//  SecondSignUpVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 2.03.2024.
//

import UIKit

class SecondSignUpVC: UIViewController {

    let imageView = UIImageView()
    let titleLabel = GCTitleLabel(textAlignment: .center, fontSize: 24)
    let bodyLabel = GCBodyLabel(textAlignment: .center, fontSize: 14)
    let emailTextFieldLabel = GCFieldTitleLabel(text: "Email")
    let emailTextField = GCAuthTextField()
    let usernameTextFieldLabel = GCFieldTitleLabel(text: "Kullanıcı Adı")
    let usernameTextField = GCAuthTextField()
    let nextButton = GCButton(type: .filled(), text: "Sonraki")
    
    var fullname: String!
    var phoneNumber: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureImageView()
        configureTitleLabel()
        configureBodyLabel()
        configureEmailTextField()
        configureUsernameTextField()
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
        
        bodyLabel.text = "Bu adımda da bilgilerini doğru girmeye dikkat et. Sana bildirimleri mailin aracılığıyla göndereceğiz. Ayrıca kendine özgü bir kullanıcı adı dolaylı olaraktan satışlarını da arttırabilir."
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureEmailTextField() {
        view.addSubviews(emailTextFieldLabel, emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextFieldLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20),
            emailTextFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextFieldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextFieldLabel.heightAnchor.constraint(equalToConstant: 15),
            
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureUsernameTextField() {
        view.addSubviews(usernameTextFieldLabel, usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextFieldLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            usernameTextFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameTextFieldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameTextFieldLabel.heightAnchor.constraint(equalToConstant: 15),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameTextFieldLabel.bottomAnchor, constant: 10),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureNextButton() {
        view.addSubview(nextButton)
        
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        nextButton.configuration?.cornerStyle = .capsule
        nextButton.tintColor = .systemGreen
        nextButton.configuration?.baseForegroundColor = .black
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Button Actions
    
    @objc private func nextButtonTouched() {
        let vc = ThirdSignUpVC()
        vc.fullname = fullname
        vc.phoneNumber = phoneNumber
        vc.username = usernameTextField.text
        vc.email = emailTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
}
