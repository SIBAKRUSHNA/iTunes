//
//  SearchViewModelTests.swift
//  iTunesTests
//
//  Created by Siba Krushna on 12/11/24.
//

import XCTest
@testable import iTunes

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
    }
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    // Test validateSearch when searchText is empty
    func testValidateSearch_withEmptySearchText_shouldShowError() {
        viewModel.searchText = ""
        viewModel.selectedTypes = ["Type1"]
    
        let isValid = viewModel.validateSearch()
        
        XCTAssertFalse(isValid)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, "Search text cannot be empty.")
    }
    
    // Test validateSearch when no content types are selected
    func testValidateSearch_withNoSelectedTypes_shouldShowError() {
        viewModel.searchText = "Test"
        viewModel.selectedTypes = []
        
        let isValid = viewModel.validateSearch()
        
        XCTAssertFalse(isValid)
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, "Please select at least one content type.")
    }
    
    // Test validateSearch when everything is valid
    func testValidateSearch_withValidInputs_shouldReturnTrue() {
        viewModel.searchText = "Test"
        viewModel.selectedTypes = ["Type1"]
        
        let isValid = viewModel.validateSearch()
        
        XCTAssertTrue(isValid)
        XCTAssertFalse(viewModel.showErrorAlert)
    }
    
    // Test toggleSelection when a type is added
    func testToggleSelection_whenAddingType_shouldAddToSelectedTypes() {
        viewModel.selectedTypes = []
        let type = "Type1"
        
        viewModel.toggleSelection(for: type)
        
        XCTAssertTrue(viewModel.selectedTypes.contains(type))
    }
    
    // Test toggleSelection when a type is removed
    func testToggleSelection_whenRemovingType_shouldRemoveFromSelectedTypes() {
        viewModel.selectedTypes = ["Type1"]
        let type = "Type1"
        
        viewModel.toggleSelection(for: type)
        
        XCTAssertFalse(viewModel.selectedTypes.contains(type))
    }
}
