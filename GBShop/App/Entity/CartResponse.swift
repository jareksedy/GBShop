//
//  CartResponse.swift
//  GBShop
//
//  Created by Ярослав on 14.12.2021.
//

import Foundation

struct CartResponse: Codable {
    var amount: Int?
    var count: Int?
    var contents: [CartContents]
}

struct CartContents: Codable {
    var productId: Int?
    var productName: String?
    var productPrice: Int?
    var quantity: Int?
}
