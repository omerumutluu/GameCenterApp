//
//  GCTitleLabel.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 29.02.2024.
//

import UIKit

class GCTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = .systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        lineBreakMode = .byTruncatingTail
        textAlignment = .center
    }
}
