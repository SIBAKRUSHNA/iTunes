//
//  SearchViewModel.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""  // Search query text
    @Published var selectedTypes: [String] = []  // Array of selected content types
    @Published var showErrorAlert: Bool = false  // Flag to show the error alert
    @Published var errorMessage: String = ""  // Error message to display in the alert
    // The first 7 content types from the ContentType enum
    var contentTypes = ContentType.allCases.prefix(7).map { $0.rawValue }
    // Validation function to check if search criteria are valid
    func validateSearch() -> Bool {
        if searchText.isEmpty {
            errorMessage = "Search text cannot be empty."  // Set error message if search text is empty
            showErrorAlert = true  // Show error alert
            return false
        } else if selectedTypes.isEmpty {
            errorMessage = "Please select at least one content type."  // Set error message if no content type is selected
            showErrorAlert = true  // Show error alert
            return false
        }
        return true  // Return true if both search text and selected types are valid
    }
    // Toggle the selection of a content type
    func toggleSelection(for type: String) {
        if selectedTypes.contains(type) {
            selectedTypes.removeAll { $0 == type }  // Remove from selection if it's already selected
        } else {
            selectedTypes.append(type)  // Add to selection if it's not already selected
        }
    }
}
