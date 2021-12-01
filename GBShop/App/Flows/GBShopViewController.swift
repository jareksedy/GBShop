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
        makeLogoutRequest()
    }
    
    // MARK: - Test methods.
    
    func makeAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        
        factory.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeSignupRequest() {
        let factory = requestFactory.makeSignupRequestFactory()
        let user = User(id: 666,
                        login: "SomebodyElse",
                        password: "mypassword",
                        email: "janedoe@gmail.com",
                        gender: "f",
                        creditCard: "2344-4324-2344-1233-1234",
                        bio: "Nothin to tell ya folks %)",
                        name: "Jane",
                        lastname: "Doe")
        
        factory.signup(user: user) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func makeLogoutRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(id: 123,
                        login: nil,
                        password: nil,
                        email: nil,
                        gender: nil,
                        creditCard: nil,
                        bio: nil,
                        name: nil,
                        lastname: nil)
        
        factory.logout(user: user) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
