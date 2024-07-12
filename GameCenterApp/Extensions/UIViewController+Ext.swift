//
//  UIViewController+Ext.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

extension UIViewController {
    func presentGCAlert(title: String, message: String, buttonTitle: String) {
        let vc = GCAlertVC(title: title, body: message, buttonTitle: buttonTitle)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}
