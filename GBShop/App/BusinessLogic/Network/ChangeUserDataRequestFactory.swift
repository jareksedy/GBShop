//
//  ChangeUserDataRequestFactory.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import Foundation
import Alamofire

protocol ChangeUserDataRequestFactory {
    func changeUserData(user: User, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
