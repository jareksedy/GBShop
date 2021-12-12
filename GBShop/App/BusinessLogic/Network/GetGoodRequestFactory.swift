//
//  GetGoodRequestFactory.swift
//  GBShop
//
//  Created by Ярослав on 04.12.2021.
//

import Foundation
import Alamofire

protocol GetGoodRequestFactory {
    func getGood(productId: Int, completionHandler: @escaping (AFDataResponse<GoodResponse>) -> Void)
}
