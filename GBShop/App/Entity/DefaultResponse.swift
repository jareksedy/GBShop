//
//  DefaultResponse.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation

struct DefaultResponse: Codable {
    var result: Int
    var successMessage: String?
    var errorMessage: String?
}
