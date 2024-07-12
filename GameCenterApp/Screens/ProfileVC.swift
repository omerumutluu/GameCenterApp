//
//  ProfileVC.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import UIKit

struct ProfileSection {
    let sectionTitle: String
    var cells: [String]
}

class ProfileVC: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var profileSections = [
        ProfileSection(sectionTitle: "Hesabım", cells: ["Kişisel Bilgilerim", "Siparişlerim", "İlanlarım", "Satışlarım", "Ödemelerim", "Kaydedilenler"]),
        ProfileSection(sectionTitle: "Destek", cells: ["Destek"]),
        ProfileSection(sectionTitle: "Çıkış", cells: ["Çıkış Yap"])
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profilim"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Bakiye: 0 ₺", style: .done, target: self, action: #selector(balanceButtonClicked))
        let balanceLabel = UILabel()
        balanceLabel.text = "Bakiye: \(AuthManager.shared.currentUser!.balance) ₺"
        balanceLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: balanceLabel)
        view.backgroundColor = .systemBackground
        
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = ProfileTableHeaderView(fullname: AuthManager.shared.currentUser!.fullname, username: AuthManager.shared.currentUser!.username, email: AuthManager.shared.currentUser!.email)
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 130)
        tableView.tableHeaderView = headerView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //MARK: - Button Actions
    
    @objc func balanceButtonClicked() {
        print("balance tıklandı babus")
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return profileSections[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = profileSections[indexPath.section].cells[indexPath.row]
        return cell!
    }
}
