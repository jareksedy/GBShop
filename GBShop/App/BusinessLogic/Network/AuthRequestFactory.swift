//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
