//
//  RequestFactory.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeSignupRequestFactory() -> SignupRequestFactory {
        let errorParser = makeErrorParser()
        return Signup(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParser = makeErrorParser()
        return ChangeUserData(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}

