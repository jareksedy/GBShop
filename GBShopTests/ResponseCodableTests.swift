//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by Ярослав on 04.12.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ResponseCodableTests: XCTestCase {
    
    struct PostStub: Codable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }
    
    enum ApiErrorStub: Error {
        case fatalError
    }
    
    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }
        
        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!
    
    override func setUpWithError() throws {
        try! super.setUpWithError()
        errorParser = ErrorParserStub()
    }
    
    override func tearDownWithError() throws {
        try! super.tearDownWithError()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse() {
        AF.request("https://jsonplaceholder.typicode.com/posts/1").responseCodable(errorParser: errorParser) {(response: DataResponse<PostStub, AFError>) in
            switch response.result {
            case .success(_): break
            case .failure:
                XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
