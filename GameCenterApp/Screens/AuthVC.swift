//
//  AuthVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class AuthVC: UIViewController {
    
    let imageView = UIImageView()
    let emailLabel = GCFieldTitleLabel(text: "Email")
    let emailTextField = GCAuthTextField()
    let passwordLabel = GCFieldTitleLabel(text: "Şifre")
    let passwordTextField = GCAuthTextField()
    let signInButton = GCButton(type: .filled(), text: "Giriş Yap", systemImage: SFSymbols.person)
    let orLabel = GCBodyLabel(textAlignment: .center, fontSize: 13)
    let orLabelFirstLine = UIView()
    let orLabelSecondLine = UIView()
    let appleButton = GCButton(type: .gray(), text: "Apple Kimliği ile Giriş", systemImage: SFSymbols.appleLogo)
    let googleButton = GCButton(type: .gray(), text: "Google Hesabı ile Giriş", systemImage: SFSymbols.googleLogo)
    let signUpButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //navigationController?.navigationBar.isHidden = true
        
        configureImageView()
        configureEmailTextField()
        configurePasswordTextField()
        configureSignInButton()
        configureOrLabel()
        configureExternalButtons()
        configureSignUpButton()
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.gamecenterLogo
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.widthAnchor.constraint(equalToConstant: 190),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func configureEmailTextField() {
        view.addSubviews(emailLabel, emailTextField)
        
        emailTextField.placeholder = "xxx@xxx.com"
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailLabel.heightAnchor.constraint(equalToConstant: 15),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configurePasswordTextField() {
        view.addSubviews(passwordLabel, passwordTextField)
        
        passwordTextField.placeholder = "******"
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
        signInButton.configuration?.baseForegroundColor = .black
        signInButton.configuration?.baseBackgroundColor = .systemGreen
        signInButton.configuration?.cornerStyle = .capsule
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureOrLabel() {
        view.addSubviews(orLabel, orLabelFirstLine, orLabelSecondLine)
        
        orLabel.text = "YA DA"
        
        orLabelFirstLine.translatesAutoresizingMaskIntoConstraints = false
        orLabelSecondLine.translatesAutoresizingMaskIntoConstraints = false
        orLabelFirstLine.backgroundColor = .secondaryLabel
        orLabelSecondLine.backgroundColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.widthAnchor.constraint(equalToConstant: 80),
            orLabel.heightAnchor.constraint(equalToConstant: 20),
            
            orLabelFirstLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            orLabelFirstLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orLabelFirstLine.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor),
            orLabelFirstLine.heightAnchor.constraint(equalToConstant: 1),
            
            orLabelSecondLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            orLabelSecondLine.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor),
            orLabelSecondLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orLabelSecondLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureExternalButtons() {
        view.addSubviews(appleButton, googleButton)
        
        appleButton.configuration?.cornerStyle = .large
        appleButton.configuration?.baseForegroundColor = .white
        appleButton.configuration?.buttonSize = .small
        appleButton.titleLabel?.textAlignment = .center
        
        googleButton.configuration?.cornerStyle = .large
        googleButton.configuration?.baseForegroundColor = .white
        googleButton.configuration?.buttonSize = .mini
        googleButton.titleLabel?.textAlignment = .center
        
        NSLayoutConstraint.activate([
            appleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 30),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleButton.widthAnchor.constraint(equalToConstant: 170),
            appleButton.heightAnchor.constraint(equalToConstant: 60),
            
            googleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 30),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleButton.widthAnchor.constraint(equalToConstant: 170),
            googleButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitleColor(.systemGreen, for: .normal)
        signUpButton.setTitle("Hala hesabınız yok mu? Kayıt Ol", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: Button Actions
    
    @objc func signInButtonClicked() {
        navigationController?.pushViewController(GCTabBarController(), animated: true)
        Task {
            AuthManager.shared.signIn(email: emailTextField.text!, password: passwordTextField.text!) { result in
                switch result {
                case .success(): Task { await AuthManager.shared.setCurrentUser() }
                    
                case .failure(let error): self.presentGCAlert(title: "Hata", message: error.rawValue, buttonTitle: "Tamam")
                }
            }
        }
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(FirstSignUpVC(), animated: true)
    }
    
    @objc func appleButtonClicked() {}
    
    @objc func googleButtonClicked() {}
}
