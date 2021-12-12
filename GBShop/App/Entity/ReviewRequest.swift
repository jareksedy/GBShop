//
//  ReviewRequest.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation

struct ReviewRequest: Codable {
    let reviewText: String?
    let userId: Int?
    let productId: Int?
}
