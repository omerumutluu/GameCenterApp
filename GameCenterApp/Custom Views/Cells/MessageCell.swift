//
//  MessageCell.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 26.02.2024.
//

import UIKit

class MessageCell: UITableViewCell {
    
    let userImageView = UIImageView()
    let usernameLabel = UILabel()
    let messageLabel = UILabel()
    let hourLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
