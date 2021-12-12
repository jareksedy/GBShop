//
//  ReviewResponse.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation

struct ReviewResponse: Codable {
    let userId: Int?
    let reviewText: String?
}
