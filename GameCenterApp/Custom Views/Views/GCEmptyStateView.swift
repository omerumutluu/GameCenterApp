//
//  GCEmptyStateView.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 3.03.2024.
//

import UIKit

protocol GCEmptyStateViewDelegate: AnyObject {
    func didTapRefreshButton()
}

class GCEmptyStateView: UIView {

    let logoImageView = UIImageView()
    let messageLabel = GCTitleLabel(textAlignment: .center, fontSize: 16)
    
    weak var delegate: GCEmptyStateViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubviews(logoImageView, messageLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage.gamecenterLogo
        logoImageView.alpha = 0.4
        messageLabel.numberOfLines = 4
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 75),
            
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            messageLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
