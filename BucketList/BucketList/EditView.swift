//
//  EditView.swift
//  BucketList
//
//  Created by ADEBOLA AKEREDOLU on 10/12/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
    var onSave: (Location) -> Void

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.location.name)
                    TextField("Description", text: $viewModel.location.description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()

                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

#Preview {
    EditView(location: Location.example) { _ in }
}
