//
//  MediaView.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI

struct MediaView: View {
    @Binding var selectedTypes: [String]  // Binding to handle the selected content types
    var contentTypes = ContentType.allCases.map { $0.rawValue }  // Get all content types from the enum
    let columns = [
        GridItem(.flexible(), spacing: 5),  // Grid layout with three flexible columns
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(contentTypes, id: \.self) { type in
                        Button(action: {
                            if selectedTypes.contains(type) {
                                selectedTypes.removeAll(where: { $0 == type })  // Remove if already selected
                            } else {
                                selectedTypes.append(type)  // Add if not selected
                            }
                        }) {
                            Text(type.capitalized)  // Display the content type in capitalized text
                                .frame(maxWidth: .infinity, minHeight: 40)  // Button size
                                .font(.system(size: 14, weight: .medium))  // Text style
                                .background((selectedTypes.contains(type)) ? Color.gray : Color.gray.opacity(0.2))  // Background color
                                .foregroundColor(.white)  // Text color
                                .cornerRadius(8)  // Rounded corners
                        }
                    }
                }
                .padding(.vertical)
                Spacer()  // Spacer to ensure proper layout
            }
        }
        .padding(.horizontal)  // Padding around the view
        .background(Color("BackgroundColor"))  // Custom background color
        .navigationTitle("Media")  // Set navigation title
        .navigationBarTitleDisplayMode(.inline)  // Inline navigation title
        .navigationBarBackButtonHidden(true)  // Hide default back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()  // Custom back button
            }
        }
    }
}

struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView(selectedTypes: .constant([""]))  // Example preview with selected types
    }
}
