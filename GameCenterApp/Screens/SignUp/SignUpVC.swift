//
//  SignUpVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class SignUpVC: UIViewController {
    
    let imageView = UIImageView()
    let emailTextField = GCAuthTextField()
    let usernameTextField = GCAuthTextField()
    let fullnameTextField = GCAuthTextField()
    let phoneNumberTextField = GCAuthTextField()
    let passwordTextField = GCAuthTextField()
    let passwordConfirmTextField = GCAuthTextField()
    let signUpButton = GCButton(type: .filled(), title: "Kayıt Ol", systemImageName: "person.badge.plus")
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Kayıt Ol"
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubviews(imageView, emailTextField, usernameTextField, fullnameTextField, phoneNumberTextField, passwordTextField, passwordConfirmTextField, signUpButton)
        
        configure()
    }
    
    private func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.gamecenterLogo
        
        emailTextField.placeholder = "Email"
        usernameTextField.placeholder = "Kullanıcı Adı"
        fullnameTextField.placeholder = "İsim Soyisim"
        phoneNumberTextField.placeholder = "Telefon Numarası"
        passwordTextField.placeholder = "Şifre"
        passwordConfirmTextField.placeholder = "Şifre Onayı"
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            
            emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            fullnameTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            fullnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            fullnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            fullnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: fullnameTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 25),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func signUpButtonClicked() {
        AuthManager.shared.signUp(email: emailTextField.text!, password: passwordTextField.text!)
    }
}
