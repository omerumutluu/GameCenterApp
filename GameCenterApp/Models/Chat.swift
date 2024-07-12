//
//  Chat.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 3.03.2024.
//

import Foundation

struct Chat: Codable {
    let id: String
    let user1Id: String
    let user2Id: String
    let advertisementId: String
    let messageIds: [String]
    
    var user1: GCUser?
    var user2: GCUser?
    var advertisement: Advertisement?
    var messages: [Message]?
}
