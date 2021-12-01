//
//  User.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import Foundation
struct User: Codable {
    let id: Int
    let login: String?
    let password: String?
    let email: String?
    let gender: String?
    let creditCard: String?
    let bio: String?
    let name: String?
    let lastname: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case password
        case email
        case gender
        case creditCard = "credit_card"
        case bio
        case name = "user_name"
        case lastname = "user_lastname"
    }
}
