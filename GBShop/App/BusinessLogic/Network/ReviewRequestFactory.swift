//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {
    func getReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[ReviewResponse]>) -> Void)
    func addReview(review: ReviewRequest, completionHandler: @escaping (AFDataResponse<DefaultResponse>) -> Void)
}
