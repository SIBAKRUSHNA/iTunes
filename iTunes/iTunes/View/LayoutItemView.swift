//
//  LayoutItemView.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI

// LayoutItemView: A view that displays a track with either a list layout or a grid layout based on the isListLayout flag
struct LayoutItemView: View {
    // @State property to toggle between list layout and grid layout
    @State var isListLayout: Bool = false
    // @State property to hold the Track data, which includes the track details
    @State var track: Track?
    var body: some View {
        VStack {
            // Conditional layout based on the 'isListLayout' flag
            if isListLayout {
                // List layout using HStack
                HStack(spacing: 10) {
                    // AsyncImage is used to load the image from a URL
                    Image.asyncImage(url: track?.artworkUrl100 ?? "")
                        .cornerRadius(12) // Rounded corners for the image
                    VStack(alignment: .leading, spacing: 10) {
                        // Display the track name
                        Text(track?.trackName ?? "")
                            .font(.system(size: 14, weight: .bold))
                            .lineLimit(2) // Limit to 2 lines if the text overflows
                            .foregroundColor(.white) // White text color
                        
                        // Display the artist name
                        Text(track?.artistName ?? "")
                            .font(.system(size: 12, weight: .medium))
                            .lineLimit(2) // Limit to 2 lines if the text overflows
                            .foregroundColor(.white) // White text color
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading) // Full width with leading alignment
            } else {
                // Grid layout using VStack (for a centered arrangement)
                VStack(spacing: 15) {
                    // AsyncImage is used to load the image from a URL
                    Image.asyncImage(url: track?.artworkUrl100 ?? "")
                        .cornerRadius(12) // Rounded corners for the image
                    
                    VStack(alignment: .center, spacing: 10) {
                        // Display the track name (center-aligned)
                        if let trackName = track?.trackName {
                            Text(trackName)
                                .font(.system(size: 14, weight: .bold))
                                .lineLimit(2) // Limit to 2 lines if the text overflows
                                .multilineTextAlignment(.center) // Center align the text
                                .foregroundColor(.white) // White text color
                        }
                        
                        // Display the artist name (center-aligned)
                        if let artistName = track?.artistName {
                            Text(artistName)
                                .font(.system(size: 12, weight: .medium))
                                .lineLimit(2) // Limit to 2 lines if the text overflows
                                .multilineTextAlignment(.center) // Center align the text
                                .foregroundColor(.white) // White text color
                        }
                    }
                }
            }
        }
        .background(Color("BackgroundColor")) // Background color of the view
    }
}

// Preview for testing the LayoutItemView component in Xcode's canvas
struct LayoutItemView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutItemView() // Preview without any track data for visual testing
            .previewLayout(.sizeThatFits) // Preview the layout that fits the content
    }
}
