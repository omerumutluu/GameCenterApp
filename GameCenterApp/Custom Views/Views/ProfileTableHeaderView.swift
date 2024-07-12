//
//  ProfileTableHeaderView.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 2.03.2024.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    static let identifier = "ProfileTableHeaderView"
    
    let imageView = UIImageView()
    let fullnameLabel = GCTitleLabel(textAlignment: .left, fontSize: 20)
    let emailLabel = GCBodyLabel(textAlignment: .left, fontSize: 13)
    let usernameLabel = GCBodyLabel(textAlignment: .left, fontSize: 15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(imageView, fullnameLabel, usernameLabel, emailLabel)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fullname: String, username: String, email: String) {
        self.init(frame: .zero)
        
        self.fullnameLabel.text = fullname
        self.usernameLabel.text = username
        self.emailLabel.text = email
        
    }
    
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.gamecenterLogo
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90),
            
            fullnameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            fullnameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            fullnameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            fullnameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            usernameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: fullnameLabel.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: fullnameLabel.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: fullnameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: fullnameLabel.trailingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
