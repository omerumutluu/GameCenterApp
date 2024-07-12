//
//  MessagesVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class MessagesVC: UIViewController {
    
    let tableView = UITableView()
    
    var chats = [Chat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mesajlar"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        configureTableView()
        
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getChats(userId: AuthManager.shared.currentUser!.id) { result in
            switch result {
            case .success(let chats):
                self.chats = chats
                
            case .failure(let error): self.presentGCAlert(title: "Hata", message: error.rawValue, buttonTitle: "Tamam")
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        
    }
}
