//
//  Advertisement.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import Foundation

struct Advertisement: Codable {
    let id: String
    let title: String
    let gameId: String
    let userId: String
    let description: String
    let imageURL: String
    let maximumDeliveryTime: String
    let price: Double
    let viewCount: Int
    let createdAt: Date
    let isActive: Bool
    
    var game: Game?
    var user: GCUser?
}
