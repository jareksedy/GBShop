//
//  GetCatalog.swift
//  GBShop
//
//  Created by Ярослав on 04.12.2021.
//

import Foundation
import Alamofire

protocol GetCatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[Catalog]>) -> Void)
}
