//
//  GBShopViewController.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import UIKit

class GBShopViewController: UIViewController {
    
    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeAuthRequest()
        makeSignupRequest()
        makeChangeUserDataRequest()
        makeGetCatalogRequest()
        makeGetGoodRequest()
        makeLogoutRequest()
        makeGetReviewsRequest()
        makeAddReviewRequest()
        makeRemoveReviewRequest()
        makeGetCartRequest()
        makePayCartRequest()
        makeAddToCartRequest()
        makeDeleteFromCartRequest()
    }
    
    // MARK: - Methods for testing purposes.
    
    // MARK: - Auth, signup, change user data & logout requests.
    func makeAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(login: "Somebody", password: "mypassword")
        
        factory.login(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeSignupRequest() {
        let factory = requestFactory.makeSignupRequestFactory()
        let user = User(login: "SomebodyElse",
                        password: "mypassword",
                        email: "janedoe@gmail.com",
                        gender: "f",
                        creditCard: "2344-4324-2344-1233-1234",
                        bio: "Nothin to tell ya folks %)",
                        name: "Jane",
                        lastname: "Doe")
        
        factory.signup(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeChangeUserDataRequest() {
        let factory = requestFactory.makeChangeUserDataRequestFactory()
        let user = User(id: 123,
                        login: "SomebodyElse",
                        password: "mypassword",
                        email: "janedoe@gmail.com",
                        gender: "f",
                        creditCard: "2344-4324-2344-1233-1234",
                        bio: "Nothin to tell ya folks %)",
                        name: "Jane",
                        lastname: "Doe")
        
        factory.changeUserData(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeLogoutRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(id: 123)
        
        factory.logout(user: user) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Get catalog & get item requests.
    func makeGetCatalogRequest() {
        let factory = requestFactory.makeGetCatalogRequestFactory()
        
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeGetGoodRequest() {
        let factory = requestFactory.makeGetGoodRequestFactory()
        
        factory.getGood(productId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Reviews requests.
    func makeGetReviewsRequest() {
        let factory = requestFactory.makeReviewsRequestFactory()
        
        factory.getReviews(productId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeAddReviewRequest() {
        let factory = requestFactory.makeReviewsRequestFactory()
        let review = ReviewRequest(reviewText: "Товар — говно! Не берите!", userId: 123, productId: 666)
        
        factory.addReview(review: review){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeRemoveReviewRequest() {
        let factory = requestFactory.makeReviewsRequestFactory()
        
        factory.removeReview(reviewId: 123){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Cart requests.
    func makeGetCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()

        factory.getCart(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makePayCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()

        factory.payCart(user: User(id: 123)){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeAddToCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()
        
        let cart = CartRequest(productId: 666, quantity: 1)

        factory.addToCart(cart: cart){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeDeleteFromCartRequest() {
        let factory = requestFactory.makeCartRequestFactory()
        
        let cart = CartRequest(productId: 666)

        factory.deleteFromCart(cart: cart){ response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
