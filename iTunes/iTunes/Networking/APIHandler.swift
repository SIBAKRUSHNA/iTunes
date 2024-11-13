//
//  APIHandler.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import Foundation

// MARK: - APIHandler Class
class APIHandler: NSObject {
    // Singleton instance of APIHandler to ensure only one instance is used throughout the app.
    static let shared = APIHandler()

    // Private initializer to prevent external instantiation of the class.
    private override init() {}

    // Function to fetch search results from the API
    func fetchSearchResults(parameter: [String: Any], success: @escaping (Result<MediaItem, APIError>) -> Void) {
        
        // Calling the API through the APIManager with the specified endpoint and parameters.
        APIManager.shared.callAPI(endPoint: APIEndPoints.search, parameters: parameter) { result in
            // Handle the result of the API call
            switch result {
            case .success(let data):
                // If the API call is successful, try to decode the response into MediaItem object
                do {
                    let mediaItems = try JSONDecoder().decode(MediaItem.self, from: data)
                    // Return the successfully decoded media items
                    success(.success(mediaItems))
                } catch {
                    // If decoding fails, return a decoding error
                    success(.failure(.decodingError))
                    print("Decoding error: \(error.localizedDescription)")
                }
            case .failure(let error):
                // If the API call fails, return the failure with the error
                success(.failure(error))
            }
        }
    }
}
