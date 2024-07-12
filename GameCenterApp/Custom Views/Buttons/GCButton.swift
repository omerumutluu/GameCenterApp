//
//  GCButton.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class GCButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: Configuration, text: String? = nil, systemImage: UIImage? = nil) {
        self.init(frame: .zero)
        
        configuration = type
        configuration?.title = text
        
        if systemImage != nil {
            configuration?.imagePlacement = .leading
            configuration?.imagePadding = 10
            configuration?.image = systemImage
        }
    }
    
    convenience init(text: String? = nil, image: UIImage) {
        self.init(frame: .zero)
        
        setImage(image, for: .normal)
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        
        setTitle(text, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
