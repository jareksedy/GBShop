//
//  RequestsTests.swift
//  GBShopTests
//
//  Created by Ярослав on 04.12.2021.
//

import XCTest
@testable import GBShop

class RequestsTests: XCTestCase {
    
    var requestFactory: RequestFactory!
    var user: User!
    
    let expectation = XCTestExpectation(description: "Perform request.")

    override func setUpWithError() throws {
        try? super.setUpWithError()
        requestFactory = RequestFactory()
        user = User(login: "SomebodyElse",
                    password: "mypassword",
                    email: "janedoe@gmail.com",
                    gender: "f",
                    creditCard: "2344-4324-2344-1233-1234",
                    bio: "Nothin to tell ya folks %)",
                    name: "Jane",
                    lastname: "Doe")
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        requestFactory = nil
        user = nil
    }

    func testShouldPerformSignupRequest() {
        let factory = requestFactory.makeSignupRequestFactory()
        factory.signup(user: user) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testShouldPerformAuthRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        factory.login(user: user) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testShouldPerformChangeUserDataRequest() {
        let factory = requestFactory.makeChangeUserDataRequestFactory()
        factory.changeUserData(user: user) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testShouldPerformLogoutRequest() {
        let factory = requestFactory.makeAuthRequestFactory()
        factory.logout(user: user) { response in
            switch response.result {
            case .success(let result): XCTAssertEqual(result.result, 1)
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
