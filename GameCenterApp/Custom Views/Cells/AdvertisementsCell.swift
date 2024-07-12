//
//  AdvertisementsCell.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 26.02.2024.
//

import UIKit
import SDWebImage

class AdvertisementsCell: UITableViewCell {
    
    static let identifier = "AdvertisementsCell"
    
    let advertisementImageView = UIImageView()
    let titleLabel = GCTitleLabel(textAlignment: .left, fontSize: 16)
    let gameNameLabel = GCBodyLabel(textAlignment: .left, fontSize: 13)
    let viewCountLabel = GCBodyLabel(textAlignment: .left, fontSize: 13)
    let priceLabel = GCTitleLabel(textAlignment: .right, fontSize: 14)
    let isActiveLabel = GCBodyLabel(textAlignment: .left, fontSize: 13)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String, gameName: String, imageURL: String, viewCount: Int, price: Double, isActive: Bool) {
        titleLabel.text = title
        gameNameLabel.text = gameName
        advertisementImageView.sd_setImage(with: URL(string: imageURL)) { image, _, _, _ in
            guard let image else {
                self.advertisementImageView.image = UIImage.gamecenterLogo
                return
            }
            self.advertisementImageView.image = image
        }
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "eye")?.withTintColor(.label)
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 18, height: 12)
        let attributedText = NSMutableAttributedString(string: "")
        attributedText.append(NSAttributedString(attachment: imageAttachment))
        attributedText.append(NSAttributedString(string: " \(viewCount)"))
        viewCountLabel.attributedText = attributedText
        priceLabel.text = "\(price) ₺"
        isActiveLabel.text = isActive ? "Aktif" : "Pasif"
    }
    
    func configure() {
        addSubviews(advertisementImageView, titleLabel, gameNameLabel, viewCountLabel, priceLabel, isActiveLabel)
        
        advertisementImageView.image = UIImage.gamecenterLogo
        advertisementImageView.translatesAutoresizingMaskIntoConstraints = false
        advertisementImageView.clipsToBounds = true
        advertisementImageView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            advertisementImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            advertisementImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            advertisementImageView.widthAnchor.constraint(equalToConstant: 110),
            advertisementImageView.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: advertisementImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: advertisementImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            gameNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            gameNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            gameNameLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            viewCountLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 10),
            viewCountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            viewCountLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            viewCountLabel.heightAnchor.constraint(equalToConstant: 20),
            
            isActiveLabel.bottomAnchor.constraint(equalTo: advertisementImageView.bottomAnchor),
            isActiveLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            isActiveLabel.widthAnchor.constraint(equalToConstant: 80),
            isActiveLabel.heightAnchor.constraint(equalToConstant: 20),
        
            priceLabel.bottomAnchor.constraint(equalTo: advertisementImageView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: isActiveLabel.trailingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
