//
//  APIManager.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import Foundation
import CommonCrypto

// MARK: - API Methods Enum
enum APIMethod: String {
    case POST, GET, PUT, DELETE
}

// MARK: - APIManager Class
class APIManager: NSObject {
    // Singleton instance of APIManager to ensure only one instance is used across the app.
    static let shared = APIManager()
    // Private initializer to prevent external instantiation of the class.
    private override init() {}
    // URLRequest object to hold the request configuration
    private var request: URLRequest?
    // Base URL for the API endpoints
    private let baseURL = "https://itunes.apple.com/"
    // Function to initiate an API call
    func callAPI(endPoint: (String, APIMethod), parameters: [String: Any]? = nil, completion: @escaping (Result<Data, APIError>) -> Void) {
        // Construct the full URL using the base URL and the endpoint
        guard let url = URL(string: baseURL + endPoint.0) else { return }
        let method = endPoint.1 // HTTP method (GET, POST, etc.)
        // Create the URLRequest with parameters if provided
        let urlRequest = createURLRequest(url: url, method: method, parameters: parameters)
        // Make the actual API call using the created URLRequest
        makeAPICalls(urlRequest, completion: completion)
    }
    // Function to create the URLRequest with HTTP method, parameters, and headers
    func createURLRequest(url: URL, method: APIMethod, parameters: [String: Any]?) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue // Set the HTTP method (GET, POST, etc.)
        // If parameters are provided, encode them into the URL's query string for GET requests
        if let parameters = parameters {
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                urlRequest.url = urlComponents.url
            }
        }
        // Set default headers for the request
        urlRequest.setValue("https", forHTTPHeaderField: "Scheme")
        urlRequest.setValue("itunes.apple.com", forHTTPHeaderField: "Authority")
        urlRequest.setValue("curl/8.7.1", forHTTPHeaderField: "User-Agent")
        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
        // Print the request for debugging purposes
        print(urlRequest)
        return urlRequest
    }
    // Function to make the actual API call using the URLSession
    private func makeAPICalls(_ request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        // Initialize the SSL pinning manager to handle SSL/TLS validation
        let sslPinningManager = SSLPinningManager()
        // Create a URLSession with the SSLPinningManager as its delegate
        let session = URLSession(configuration: .default, delegate: sslPinningManager, delegateQueue: nil)
        // Start a data task with the provided request
        let task = session.dataTask(with: request) { data, response, error in
            // Handle any errors that occur during the request
            if let error = error {
                completion(.failure(.requestFailed(error))) // Return the error through completion
                print("Error: \(error.localizedDescription)") // Log the error
                return
            }
            // If no data is received, return an unknown error
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            // If data is received, return it as a success result
            completion(.success(data))
        }
        // Start the task to make the API call
        task.resume()
    }
}
