//
//  Message.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 3.03.2024.
//

import Foundation

struct Message: Codable {
    let id: String
    let userId: String
    let message: String
    let date: Date
    let isReaded: Bool
    let isEdited: Bool
    let isDeleted: Bool
}
