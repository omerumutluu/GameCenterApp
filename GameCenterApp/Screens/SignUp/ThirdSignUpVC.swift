//
//  ThirdSignUpVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 2.03.2024.
//

import UIKit

class ThirdSignUpVC: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = GCTitleLabel(textAlignment: .center, fontSize: 24)
    let bodyLabel = GCBodyLabel(textAlignment: .center, fontSize: 14)
    let passwordTextFieldLabel = GCFieldTitleLabel(text: "Şifre")
    let passwordTextField = GCAuthTextField()
    let passwordConfirmTextFieldLabel = GCFieldTitleLabel(text: "Şifre Onayı")
    let passwordConfirmTextField = GCAuthTextField()
    let signUpButton = GCButton(type: .filled(), text: "Kayıt Ol")
    
    var fullname: String!
    var phoneNumber: String!
    var email: String!
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureImageView()
        configureTitleLabel()
        configureBodyLabel()
        configurePasswordTextField()
        configurePasswordConfirmTextField()
        configureSignUpButton()
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
        
        titleLabel.text = "Şifre Belirleme"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureBodyLabel() {
        view.addSubview(bodyLabel)
        
        bodyLabel.text = "Game Center bakiye sistemiyle çalıştığı için hesabınızı güçlü bir şifre belirleyerek korumak sizin sorumluğunuzdadır. Doğum tarihi, yıldönümü gibi klasik şifre belirleme yöntemlerinden kaçınınız."
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configurePasswordTextField() {
        view.addSubviews(passwordTextFieldLabel, passwordTextField)
        
        passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordTextFieldLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20),
            passwordTextFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextFieldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextFieldLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePasswordConfirmTextField() {
        view.addSubviews(passwordConfirmTextFieldLabel, passwordConfirmTextField)
        
        passwordConfirmTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordConfirmTextFieldLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            passwordConfirmTextFieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordConfirmTextFieldLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordConfirmTextFieldLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordConfirmTextFieldLabel.bottomAnchor, constant: 10),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.configuration?.cornerStyle = .capsule
        signUpButton.tintColor = .systemGreen
        signUpButton.configuration?.baseForegroundColor = .black
        
        signUpButton.addTarget(self, action: #selector(confirmButtonTouched), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Button Actions
    
    @objc private func confirmButtonTouched() {
        let user = GCUser(
            id: UUID().uuidString,
            email: email,
            username: username,
            fullname: fullname,
            imageURL: "",
            phoneNumber: phoneNumber,
            balance: 0,
            successedOrder: 0,
            canceledOrder: 0,
            isPhoneNumberVerified: false,
            isEmailVerified: false,
            isIdentityVerified: false
        )
        
        AuthManager.shared.signUp(email: email, password: passwordTextField.text!)
        
        APICaller.shared.add(user: user) { error in
            guard error == nil else {
                self.presentGCAlert(title: "Hata", message: error!.rawValue, buttonTitle: "Tamam")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
