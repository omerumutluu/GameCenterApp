//
//  GCTextField.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class GCAuthTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 20
        /*
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondaryLabel.cgColor
        */
        
        textColor = .label
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .regular)
        adjustsFontSizeToFitWidth = true
        
        backgroundColor = .secondarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
    }
}
