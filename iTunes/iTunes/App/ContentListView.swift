//
//  ContentListView.swift
//  iTunes
//
//  Created by Siba Krushna on 12/11/24.
//

import SwiftUI

struct ContentListView: View {
    // State variables to manage the layout, search text, and selected media types
    @State private var isGrid = true  // Boolean to toggle between grid and list layout
    @State var searchText: String  // Text for the search term
    @State var selectedTypes: [String]  // Media types selected for filtering
    @StateObject private var viewModel = ContentListViewModel()  // ViewModel to handle the logic and API calls
    // Computed property to group the search results by their kind (e.g., album, track, etc.)
    var groupedResultsByKind: [String: [Track]] {
        Dictionary(grouping: viewModel.searchResults, by: { $0.kind ?? "None" })
    }
    // Columns configuration for the grid layout
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea() // Make background color fill the entire screen
            VStack {
                // Segmented control to switch between grid and list layouts
                Picker(selection: $isGrid, label: Text("Layout")) {
                    Text("Grid Layout").tag(true)
                    Text("List Layout").tag(false)
                }
                .frame(height: 40)
                .pickerStyle(.segmented)
                .opacity((!viewModel.isLoading && viewModel.errorMessage == nil) ? 1 : 0) // Hide when loading or error occurs
                
                // Loader for showing progress when fetching data
                if viewModel.isLoading {
                    ProgressView() {
                        Text("Loading...")
                            .foregroundColor(.white)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    // Show error message if the request fails
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    // Display content based on layout selection
                    ScrollView {
                        if isGrid {
                            // If grid layout is selected
                            LazyVStack(spacing: 0) {
                                ForEach(groupedResultsByKind.keys.sorted{$0 > $1}, id: \.self) { key in
                                    let values = groupedResultsByKind[key] ?? []
                                    
                                    Section(header: HStack {
                                        Text("\(key.capitalized)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(10)
                                        Spacer()
                                    }
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .padding()) {
                                        // Grid layout for displaying content
                                        LazyVGrid(columns: columns, spacing: 15) {
                                            ForEach(values, id: \.self) { value in
                                                NavigationLink(destination: DescriptionView(track: value)) {
                                                    LayoutItemView(isListLayout: false, track: value) // Use the LayoutItemView for grid items
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        } else {
                            // If list layout is selected
                            LazyVStack(spacing: 0) {
                                ForEach(groupedResultsByKind.keys.sorted{$0 > $1}, id: \.self) { key in
                                    let values = groupedResultsByKind[key] ?? []
                                    
                                    Section(header: HStack {
                                        Text("\(key.capitalized)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(10)
                                        Spacer()
                                    }
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .padding()) {
                                        // List layout for displaying content
                                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10)], spacing: 10) {
                                            ForEach(values, id: \.self) { value in
                                                NavigationLink(destination: DescriptionView(track: value)) {
                                                    LayoutItemView(isListLayout: true, track: value) // Use LayoutItemView for list items
                                                        .frame(maxWidth: .infinity, maxHeight: 150)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("iTunes") // Set the navigation title
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true) // Hide the default back button
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton() // Reusable custom back button
                }
            }
            .onAppear {
                // Trigger the media search when the view appears
                viewModel.searchMedia(searchText, mediaTypes: selectedTypes)
            }
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView(searchText: "", selectedTypes: [""]) // Example preview with empty values
    }
}
