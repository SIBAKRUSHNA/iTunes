//
//  DescriptionView.swift
//  iTunes
//
//  Created by Siba Krushna on 13/11/24.
//

import SwiftUI

// DescriptionView: A view that displays detailed information about a track (including artwork, name, artist, genre, and description)
struct DescriptionView: View {
    // @State property to hold the track data to be displayed
    @State var track: Track?
    var body: some View {
        VStack(spacing: 20) {
            // Display track artwork as an image with corner radius
            Image.asyncImage(url: track?.artworkUrl100 ?? "")
                .cornerRadius(20) // Rounded corners for the image
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 3) // Full width with limited height
            // VStack for displaying track name, artist name, and genre
            VStack(spacing: 10) {
                // HStack for track name and preview link icon
                HStack {
                    // Display a link icon if there is a preview URL for the track
                    if let url = track?.previewUrl, let previewUrl = URL(string: url)  {
                        Link(destination: previewUrl) {
                            // Safari icon for opening the preview URL
                            Image(systemName: "safari")
                                .font(.system(size: 20))
                                .foregroundColor(.blue) // Blue color for the icon
                        }
                    }
                    // Display track name if available
                    if let trackName = track?.trackName {
                        Text(trackName)
                            .lineLimit(2) // Limit to two lines if the text overflows
                            .font(.system(size: 16, weight: .bold)) // Bold font for track name
                            .fontWeight(.bold)
                    }
                }
                .offset(x: -10) // Adjust the offset for visual alignment
                // VStack for displaying artist name and genre
                VStack(spacing: 5) {
                    // Display artist name if available
                    if let artistName = track?.artistName {
                        Text(artistName)
                            .lineLimit(2) // Limit to two lines if the text overflows
                            .font(.subheadline) // Use subheadline font style
                            .foregroundColor(.secondary) // Secondary color for the artist name
                    }
                    // Display genre name if available
                    if let primaryGenreName = track?.primaryGenreName {
                        Text(primaryGenreName)
                            .lineLimit(2) // Limit to two lines if the text overflows
                            .font(.caption) // Use caption font style for genre
                            .foregroundColor(.orange) // Orange color for genre name
                    }
                }
            }
            // Display long description if available
            if let longDescription = track?.longDescription {
                Text(longDescription)
                    .font(.body) // Body font style for description
                    .multilineTextAlignment(.center) // Center the text
                    .padding(15) // Add padding around the description text
            }
        }
        .navigationBarTitle("Description") // Set the navigation title
        .navigationBarTitleDisplayMode(.inline) // Display title in the inline style
        .navigationBarBackButtonHidden(true) // Hide the default back button
        // Custom toolbar with a back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton() // Custom back button that pops the view
            }
        }
    }
}
// Preview for testing the DescriptionView component in Xcode's canvas
struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView() // Preview the DescriptionView without any track data
    }
}

