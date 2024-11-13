//
//  Image+Extension.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import SwiftUI

// Extension for the Image view to provide a static method for async image loading
extension Image {
    // Static method that creates an AsyncImageView, allowing for an easy call to load images
    static func asyncImage(url: String, placeholder: Image = Image(systemName: "photo.fill")) -> some View {
        // Return an instance of AsyncImageView with the provided URL and placeholder image
        AsyncImageView(url: url, placeholder: placeholder)
    }
}
// View that handles downloading and displaying an image asynchronously
struct AsyncImageView: View {
    let url: String // URL of the image to be downloaded
    let placeholder: Image // Placeholder image shown while loading
    
    @State private var downloadedImage: UIImage? = nil // State variable to store the downloaded image
    @State private var isLoading: Bool = true // State to indicate if the image is loading or not

    var body: some View {
        Group {
            // If the image is successfully downloaded, display it
            if let image = downloadedImage {
                Image(uiImage: image) // Use the downloaded UIImage to create a SwiftUI Image
                    .resizable() // Make the image resizable
                    .scaledToFit() // Scale the image to fit the available space
            } else {
                // If the image is still being downloaded, show the placeholder
                placeholder
                    .resizable() // Make the placeholder resizable
                    .scaledToFit() // Scale the placeholder to fit the available space
                    .tint(Color.gray.opacity(0.3)) // Apply a gray tint to the placeholder
                    .onAppear {
                        // Start downloading the image when the view appears
                        downloadImage(from: url)
                    }
            }
        }
        .clipped() // Clip the image to ensure it fits within its bounds
    }
    // Function to download the image from the given URL string
    private func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return } // Ensure the URL is valid
        
        // Perform the image download asynchronously using URLSession
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Check if the data exists, there are no errors, and it can be converted to an image
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                return // Return early if there was an error
            }
            // Update the UI on the main thread when the image is successfully downloaded
            DispatchQueue.main.async {
                self.downloadedImage = image // Store the downloaded image
                self.isLoading = false // Set loading to false since the image is ready
            }
        }.resume() // Start the download task
    }
}
