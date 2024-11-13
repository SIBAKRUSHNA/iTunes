//
//  CustomBackButton.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI

// CustomBackButton: A custom back button to dismiss the current view
struct CustomBackButton: View {
    // @Environment property wrapper to access the presentation mode and dismiss the current view
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        // Button with an action that dismisses the current view when tapped
        Button(action: {
            // Dismiss the current view using the presentation mode's wrappedValue
            presentationMode.wrappedValue.dismiss()
        }) {
            // Horizontal stack to arrange the back button components
            HStack {
                // Image for the back arrow, using SF Symbols
                Image(systemName: "arrow.left")
                    .resizable() // Allow resizing of the image
                    .frame(width: 25, height: 20) // Set width and height for the arrow
                    .tint(.gray) // Set the tint color for the image (gray)
            }
        }
    }
}
