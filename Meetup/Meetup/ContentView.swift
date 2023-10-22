//
//  ContentView.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/14/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section("Add New") {
                    if let newImage = viewModel.image {
                        List {
                            HStack {
                                newImage
                                    .resizable()
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)

                                TextField("Person Name", text: $viewModel.newPerson.name)
                                    .padding(.horizontal)
                            }
                            Button("Save") {
                                viewModel.save()
                            }
                            .disabled(viewModel.newPerson.name.count < 2)
                            Button("Cancel") {
                                viewModel.cancel()
                            }
                        }

                    } else {
                        Button(action: {
                            viewModel.showingImagePicker = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Add new person")
                                Spacer()
                            }
                        }
                    }
                }

                Section("People") {
                    List {
                        ForEach(viewModel.people.sorted()) { person in
                            NavigationLink {
                                DetailView(person: person)
                            } label: {
                                PersonClip(person: person)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Meetup")
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.newPerson.image)
            }
            .onChange(of: viewModel.newPerson.image) { _ in viewModel.loadImage() }
        }
    }
}

#Preview {
    ContentView()
}
