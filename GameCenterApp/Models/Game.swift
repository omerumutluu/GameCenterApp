//
//  Game.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import Foundation

struct Game: Codable {
    let id: String
    let name: String
    let imageURL: String
    let isPopular: Bool
}
