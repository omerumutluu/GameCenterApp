//
//  GCUser.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import Foundation

struct GCUser: Codable {
    let id: String
    let email: String
    let username: String
    let fullname: String
    let imageURL: String
    let phoneNumber: String
    let balance: Double
    let successedOrder: Int
    let canceledOrder: Int
    let isPhoneNumberVerified: Bool
    let isEmailVerified: Bool
    let isIdentityVerified: Bool
}
