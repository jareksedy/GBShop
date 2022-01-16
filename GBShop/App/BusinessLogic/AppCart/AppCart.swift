//
//  Cart.swift
//  GBShop
//
//  Created by Ярослав on 15.01.2022.
//

import Foundation

class AppCart {
    static let shared = AppCart()
    init(){}
    
    var items: [AppCartItem] = []
}

struct AppCartItem {
    let productId: Int?
    let productName: String?
    let price: Int?
    let picUrl: String?
}
