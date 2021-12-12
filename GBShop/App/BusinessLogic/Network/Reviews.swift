//
//  Reviews.swift
//  GBShop
//
//  Created by Ярослав on 12.12.2021.
//

import Foundation
import Alamofire

class Reviews: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://shrouded-mountain-46406.herokuapp.com/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension Reviews: ReviewRequestFactory {
    func getReviews(productId: Int, completionHandler: @escaping (AFDataResponse<[ReviewResponse]>) -> Void) {
        let requestModel = GetReviews(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Reviews {
    struct GetReviews: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getreviews"

        let productId: Int

        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
}
