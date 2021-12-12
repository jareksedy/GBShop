//
//  CatalogResponse.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation

struct CatalogResponse: Codable {
    let productId: Int?
    let productName: String?
    let price: Int?
}
