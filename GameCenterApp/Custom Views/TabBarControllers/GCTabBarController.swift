//
//  GCTabBarController.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class GCTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .systemGreen
        
        setViewControllers([createHomeViewController(), createAdvertisementsViewController(), createMessagesViewController(), createProfileViewController()], animated: true)
    }
    
    private func createHomeViewController() -> UINavigationController {
        let controller = UINavigationController(rootViewController: HomeVC())
        
        controller.title = "Keşfet"
        controller.tabBarItem = UITabBarItem(title: "Keşfet", image: SFSymbols.home, selectedImage: SFSymbols.homeFill)
        
        return controller
    }
    
    private func createAdvertisementsViewController() -> UINavigationController {
        let controller = UINavigationController(rootViewController: AdvertisementsVC())
        
        controller.title = "İlanlarım"
        controller.tabBarItem = UITabBarItem(title: "İlanlarım", image: SFSymbols.list, selectedImage: SFSymbols.listFill)
        
        return controller
    }
    
    private func createMessagesViewController() -> UINavigationController {
        let controller = UINavigationController(rootViewController: MessagesVC())
        
        controller.title = "Mesajlar"
        controller.tabBarItem = UITabBarItem(title: "Mesajlar", image: SFSymbols.message, selectedImage: SFSymbols.messageFill)
        
        return controller
    }
    
    private func createProfileViewController() -> UINavigationController {
        let controller = UINavigationController(rootViewController: ProfileVC())
        
        controller.title = "Profilim"
        controller.tabBarItem = UITabBarItem(title: "Profilim", image: SFSymbols.person, selectedImage: SFSymbols.personFill)
        
        return controller
    }
}
