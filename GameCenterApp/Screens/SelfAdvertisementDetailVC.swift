//
//  SelfAdvertisementDetailVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 8.03.2024.
//

import UIKit
import SDWebImage

class SelfAdvertisementDetailVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let advertisementImageView = UIImageView()
    let copyIdButton = GCButton(type: .filled(), text: "", systemImage: SFSymbols.documentFill)
    let idLabel = GCBodyLabel(textAlignment: .center, fontSize: 10)
    let titleLabel = GCTitleLabel(textAlignment: .left, fontSize: 16)
    let gameImageView = UIImageView()
    let gameLabel = GCBodyLabel(textAlignment: .left, fontSize: 12)
    let descriptionLabel = GCBodyLabel(textAlignment: .left, fontSize: 12)
    let maximumDeliveryTimeLabel = GCBodyLabel(textAlignment: .left, fontSize: 12)
    let priceLabel = GCTitleLabel(textAlignment: .left, fontSize: 12)
    let viewCountLabel = GCBodyLabel(textAlignment: .left, fontSize: 12)
    let createdAtLabel = GCBodyLabel(textAlignment: .left, fontSize: 12)
    let isActiveLabel = GCBodyLabel(textAlignment: .left, fontSize: 12)
    
    var advertisement: Advertisement!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        configureScrollView()
        configureContentView()
        configureAdvertisementImageView()
        configureCopyIdButton()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureContentView() {
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 540)])
    }
    
    private func configureAdvertisementImageView() {
        contentView.addSubview(advertisementImageView)
        
        advertisementImageView.translatesAutoresizingMaskIntoConstraints = false
        advertisementImageView.clipsToBounds = true
        advertisementImageView.layer.cornerRadius = 10
        advertisementImageView.sd_setImage(with: URL(string: advertisement.imageURL), placeholderImage: UIImage.touchToSelect)
        
        NSLayoutConstraint.activate([
            advertisementImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            advertisementImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            advertisementImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            advertisementImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureCopyIdButton() {
        contentView.addSubview(copyIdButton)
        
        copyIdButton.backgroundColor = .secondarySystemBackground
        copyIdButton.layer.borderWidth = 2
        copyIdButton.layer.borderColor = UIColor.systemGray.cgColor
        
        copyIdButton.layer.shadowColor = UIColor.systemGray.cgColor
        copyIdButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        copyIdButton.layer.shadowRadius = 8
        copyIdButton.layer.shadowOpacity = 0.5
        copyIdButton.clipsToBounds = true
        copyIdButton.layer.masksToBounds = false
        
        copyIdButton.tintColor = .secondaryLabel
        
        let tgr = UITapGestureRecognizer()
        tgr.addTarget(self, action: #selector(shakeButton))
        copyIdButton.addGestureRecognizer(tgr)
        copyIdButton.addTarget(self, action: #selector(shakeButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            copyIdButton.topAnchor.constraint(equalTo: advertisementImageView.bottomAnchor, constant: 20),
            copyIdButton.trailingAnchor.constraint(equalTo: advertisementImageView.trailingAnchor, constant: -20),
            copyIdButton.widthAnchor.constraint(equalToConstant: 300),
            copyIdButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func shakeButton() {
        print("deneme")
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: copyIdButton.center.x - 6, y: copyIdButton.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: copyIdButton.center.x + 6, y: copyIdButton.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        copyIdButton.layer.add(shake, forKey: "position")
    }
}
