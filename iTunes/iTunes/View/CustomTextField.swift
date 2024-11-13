//
//  CustomTextField.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI
// CustomTextField: A custom text field with a placeholder title and styling
struct CustomTextField: View {
    // @State variable to hold the textField's title (label text)
    @State var textFieldTitle = ""
    // @Binding to allow two-way data binding between the view and its parent
    @Binding var textFieldText: String
    var body: some View {
        // ZStack allows placing the placeholder text on top of the TextField
        ZStack(alignment: .leading) {
            // Show the placeholder text if the text field is empty
            if textFieldText.isEmpty {
                Text(textFieldTitle)
                    .foregroundColor(.white.opacity(0.5)) // Light white color with opacity
                    .padding(.leading, 15) // Add padding to position the placeholder text
            }
            // The actual TextField, bound to the textFieldText property
            TextField(textFieldTitle, text: $textFieldText)
                .padding() // Add padding inside the text field for better spacing
                .frame(height: 50) // Set a fixed height for the text field
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners for the text field
                .foregroundColor(.white) // White text color
                .tint(.white) // White cursor and selection tint
                .overlay {
                    // A rounded rectangle overlay with a gray border to visually define the text field
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.5) // Gray border with light line width
                }
        }
    }
}
// Preview for the CustomTextField component in Xcode's preview canvas
struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        // Provide an empty text field for preview
        CustomTextField(textFieldText: .constant(""))
    }
}
