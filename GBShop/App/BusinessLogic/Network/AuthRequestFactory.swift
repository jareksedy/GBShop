//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
    func logout(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
