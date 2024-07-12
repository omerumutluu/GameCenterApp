//
//  AdvertisementsVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

class AdvertisementsVC: GCDataLoadingVC {
    
    let tableView = UITableView()
    
    var refreshControl: UIRefreshControl!
    
    var advertisements = [Advertisement]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "İlanlarım"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        view.backgroundColor = .systemBackground
        
        configureTableView()
        fetchData()
    }
    
    private func fetchData() {
        showLoadingView()
        advertisements = []
        
        APICaller.shared.getAdvertisements(userId: AuthManager.shared.currentUser!.id) { result in
            switch result {
            case .success(let advertisements):
                self.advertisements = advertisements
                DispatchQueue.main.async { self.tableView.reloadData() }
                
                if advertisements.count == 0 {
                    self.showEmptyStateView(with: "Verilmiş bir ilanınızı bulamadık. Yeni ilan ekleyerek satış yapmaya başlayabilirsiniz.", in: self.view)
                }
                
                self.refreshControl.endRefreshing()
                self.dismissLoadingView()
                
            case .failure(let error):
                self.presentGCAlert(title: "Hata", message: error.rawValue, buttonTitle: "Tamam")
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 140
        tableView.register(AdvertisementsCell.self, forCellReuseIdentifier: AdvertisementsCell.identifier)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Yenile")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh() {
        fetchData()
    }
    
    @objc func addButtonClicked() {
        navigationController?.pushViewController(AddAdvertisementVC(), animated: true)
    }
}

extension AdvertisementsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementsCell.identifier, for: indexPath) as! AdvertisementsCell
        let advertisement = advertisements[indexPath.row]
        cell.set(title: advertisement.title, gameName: advertisement.game!.name, imageURL: advertisement.imageURL, viewCount: advertisement.viewCount, price: advertisement.price, isActive: advertisement.isActive)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelfAdvertisementDetailVC()
        vc.advertisement = advertisements[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
