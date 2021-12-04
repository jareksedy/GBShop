//
//  Good.swift
//  GBShop
//
//  Created by Ярослав on 04.12.2021.
//

import Foundation

struct Good: Codable {
    let result: Int?
    let price: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case price = "product_price"
        case description = "product_description"
    }
}
