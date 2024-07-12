//
//  GCAlertVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 29.02.2024.
//

import UIKit

class GCAlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel = GCTitleLabel(textAlignment: .center, fontSize: 18)
    let bodyLabel = GCBodyLabel(textAlignment: .center, fontSize: 13)
    let actionButon = GCButton(type: .filled())
    
    var alertTitle: String?
    var body: String?
    var buttonTitle: String?
    
    
    init(title: String, body: String? = nil, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.body = body
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        view.backgroundColor = .black.withAlphaComponent(0.75)
        
        containerView.addSubviews(titleLabel, bodyLabel, actionButon)
        
        configureContainerView()
        configureTitleLabel()
        configureBodyLabel()
        configureButton()
    }
    
    private func configureContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 215)
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureBodyLabel() {
        bodyLabel.text = body
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            bodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func configureButton() {
        actionButon.configuration?.baseBackgroundColor = .systemRed
        actionButon.configuration?.baseForegroundColor = .white
        actionButon.setTitle(buttonTitle, for: .normal)
        actionButon.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButon.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 20),
            actionButon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            actionButon.heightAnchor.constraint(equalToConstant: 40),
            actionButon.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
