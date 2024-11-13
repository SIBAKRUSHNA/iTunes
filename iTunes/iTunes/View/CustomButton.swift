//
//  CustomButton.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI

// CustomButton: A reusable customizable button with a title, title color, background color, and action
struct CustomButton: View {
    // @State variable for the title text of the button (default is "Submit")
    @State var title = "Submit"
    // @State variable for the title color of the button (default is white)
    @State var titleColor = Color.white
    // @State variable for the background color of the button (default is black)
    @State var backgroundColor = Color.black
    // Closure that represents the button's action (required parameter)
    @State var buttonActon: (() -> Void)
    var body: some View {
        // Button with the action triggered when tapped
        Button {
            // Executes the provided button action
            buttonActon()
        } label: {
            // Text view for the button title
            Text(title)
                // Make the button take up maximum width and a minimum height
                .frame(maxWidth: .infinity, minHeight: 50)
                // Custom font style for the title
                .font(.system(size: 18, weight: .medium, design: .rounded))
                // Set the title color
                .foregroundColor(titleColor)
                // Set the background color for the button
                .background(backgroundColor)
                // Apply rounded corners to the button
                .clipShape(RoundedRectangle(cornerRadius: 10))
                // Add a shadow effect to the button for visual depth
                .shadow(color: .black, radius: 12, y: 10)
        }
    }
}
// Preview for testing the CustomButton component
struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with an empty action closure for testing
        CustomButton(buttonActon: {
        })
    }
}


