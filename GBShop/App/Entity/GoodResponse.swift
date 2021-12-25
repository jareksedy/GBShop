//
//  GoodResponse.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation

struct GoodResponse: Codable {
    let result: Int?
    let productId: Int?
    let productName: String?
    let price: Int?
    let description: String?
    let picUrl: String?
}
