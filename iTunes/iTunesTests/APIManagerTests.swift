//
//  APIManagerTests.swift
//  iTunesTests
//
//  Created by Siba Krushna on 13/11/24.
//

import XCTest
@testable import iTunes


class APIManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }

    func testAPICallSuccess() {
        // Given
        let expectation = self.expectation(description: "API call completes successfully")

        // When
        APIManager.shared.callAPI(endPoint: ("search", .GET)) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertEqual(String(data: data, encoding: .utf8), "\n\n\n{\n \"resultCount\":0,\n \"results\": []\n}\n\n\n")
            case .failure:
                XCTFail("Expected success but got failure.")
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testCreateURLRequest() {
        // Given
        let url = URL(string: "https://itunes.apple.com/search")!
        let parameters = ["term": "swift", "country": "us"]
        let urlRequest = APIManager.shared.createURLRequest(url: url, method: .GET, parameters: parameters)
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://itunes.apple.com/search?term=swift&country=us")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Scheme"), "https")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authority"), "itunes.apple.com")
    }
}
