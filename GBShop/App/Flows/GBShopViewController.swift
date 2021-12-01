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
    }
    
    // MARK: - Test methods.
    
    func makeAuthRequest() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
