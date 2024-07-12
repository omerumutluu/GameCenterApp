//
//  GCFormTitleLabel.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 28.02.2024.
//

import UIKit

class GCFieldTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = .systemFont(ofSize: 13, weight: .semibold)
        textColor = .secondaryLabel
        textAlignment = .left
    }
}
