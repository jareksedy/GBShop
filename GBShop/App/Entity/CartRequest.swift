//
//  CartRequest.swift
//  GBShop
//
//  Created by Ярослав on 14.12.2021.
//

import Foundation

struct CartRequest: Codable {
    var productId: Int?
    var quantity: Int?
}
