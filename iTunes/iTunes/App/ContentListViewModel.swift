//
//  ContentListViewModel.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import Foundation

// ContentListViewModel: A ViewModel that handles the search logic and manages the state of the search operation
class ContentListViewModel: ObservableObject {
    // Published properties to bind the data to the UI (view)
    @Published var searchResults: [Track] = [] // Holds the search results for tracks
    @Published var isLoading = false // Indicates whether the search is loading
    @Published var errorMessage: String? // Holds the error message in case of a failure
    // Private function to return the parameters needed for the API call
    private func returnParameter(_ searchText: String, mediaTypes: [String]) -> [String: Any] {
        return [
            "term": searchText, // Search term entered by the user
            "mediaTypes": mediaTypes.joined(separator: ", ") // Convert the media types array into a comma-separated string
        ]
    }
    // Function to perform the media search operation
    func searchMedia(_ searchText: String, mediaTypes: [String]) {
        isLoading = true // Set isLoading to true when the search starts
        // Call the APIHandler's fetchSearchResults function
        APIHandler.shared.fetchSearchResults(parameter: returnParameter(searchText, mediaTypes: mediaTypes)) { result in
            // Update the UI on the main thread when the request is finished
            DispatchQueue.main.async {
                self.isLoading = false // Set isLoading to false when the request is done
                switch result {
                case .success(let mediaItem):
                    // If mediaItem has results, assign them to searchResults
                    if let results = mediaItem.results, !results.isEmpty {
                        self.searchResults = results
                    } else {
                        // If no results are found, set an appropriate error message
                        self.errorMessage = "Sorry! No result found"
                    }
                case .failure(let error):
                    // If the request fails, set the error message
                    self.errorMessage = "Failed to load data: \(error)"
                }
            }
        }
    }
}

