//
//  SearchView.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel() // ViewModel to handle the logic and data
    @State private var isShowContentListView = false // State to control the navigation to content list view
    // Layout configuration for LazyVGrid to create a grid of buttons
    let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer() // Spacer to position content correctly
                VStack(spacing: 50) {
                    ZStack {
                        // Gradient background for the top header
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.pink]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                        .mask(
                            HStack {
                                // Apple Logo
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .offset(x: 3, y: -3)
                                
                                // Title Text "iTunes"
                                Text("iTunes")
                                    .font(.system(size: 28, weight: .bold))
                            }
                        )
                    }
                    .frame(height: 50) // Adjust the frame height as needed
                    // Description text below the header
                    Text("Search for a variety of content from the iTunes store including iBooks, movies, podcasts, music, music videos, and audiobooks.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                // Custom TextField for search input
                CustomTextField(textFieldTitle: "Search", textFieldText: $viewModel.searchText)
                
                // Instructional text for content type selection
                Text("Specify the parameter for the content to be searched")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                
                HStack {
                    LazyVGrid(columns: columns, spacing: 5) {
                        // Loop through contentTypes in viewModel and create buttons for each type
                        ForEach(viewModel.contentTypes, id: \.self) { type in
                            Button(action: {
                                // Toggle selection state for the content type
                                viewModel.toggleSelection(for: type)
                            }) {
                                // If this is the last content type, show a "More" button leading to a new view
                                if viewModel.contentTypes.last == type {
                                    NavigationLink {
                                        // Navigation to MediaView when "More" is selected
                                        MediaView(selectedTypes: $viewModel.selectedTypes)
                                    } label: {
                                        Text("More")
                                            .font(.system(size: 15, weight: .bold))
                                            .offset(x: -10, y: 2)
                                    }
                                } else {
                                    // Display the content type button with selected state highlighting
                                    Text(type.capitalized)
                                        .frame(maxWidth: .infinity, minHeight: 35)
                                        .font(.system(size: 12, weight: .medium))
                                        .background((viewModel.selectedTypes.contains(type)) ? Color.gray : Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                // Submit Button to initiate search
                CustomButton(title: "Submit", backgroundColor: Color("ButtonColor"), buttonActon: {
                    // Validate the search and navigate to the content list view if valid
                    if viewModel.validateSearch() {
                        isShowContentListView = true
                    }
                })
                // NavigationLink to navigate to ContentListView when search is submitted
                NavigationLink(destination: ContentListView(searchText: viewModel.searchText, selectedTypes: viewModel.selectedTypes), isActive: $isShowContentListView) { EmptyView() }
                Spacer() // Spacer to adjust layout
            }
            .padding()
            .background(Color("BackgroundColor")) // Set background color
            .foregroundColor(.white) // Set foreground text color to white
            .alert(isPresented: $viewModel.showErrorAlert) {
                // Show an error alert if there is an issue with the search
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() // Preview for the SearchView
    }
}
