//
//  ContentListViewModelTests.swift
//  iTunesTests
//
//  Created by Siba Krushna on 13/11/24.
//

import XCTest
@testable import iTunes

class ContentListViewModelTests: XCTestCase {
    var viewModel: ContentListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ContentListViewModel()
    }
    
    func testSearchMediaSuccess() {
        
        // Act
        viewModel.searchMedia("test", mediaTypes: ["music"])
        
        // Wait for the asynchronous call to complete
        let expectation = XCTestExpectation(description: "Wait for async completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Assert
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(self.viewModel.searchResults.count, 55)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchMediaNoResults() {
        
        // Act
        viewModel.searchMedia("fsjfasjdfsf", mediaTypes: ["music"])
        
        // Wait for the asynchronous call to complete
        let expectation = XCTestExpectation(description: "Wait for async completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Assert
            XCTAssertEqual(self.viewModel.searchResults.count, 0)
            XCTAssertEqual(self.viewModel.errorMessage, "Sorry! No result found")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
}
