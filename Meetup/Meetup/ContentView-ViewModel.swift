//
//  ContentView-ViewModel.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/16/23.
//

import Foundation
import SwiftUI
import UIKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var people: [Person]
        @Published var showingImagePicker = false
        @Published var image: Image?
        @Published var newPerson = Person(name: "", image: nil)
        let locationFetcher = LocationFetcher()

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                locationFetcher.start()
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }

        func loadImage() {
            guard let inputImage = newPerson.image else { return }
            image = Image(uiImage: inputImage)
        }

        func save() {
            if let location = locationFetcher.lastKnownLocation {
                newPerson.latitude = location.latitude
                newPerson.longitude = location.longitude
                print("saved Location")
            }
            people.append(newPerson)
            image = nil
            newPerson.image = nil
            newPerson.name = ""
            newPerson.latitude = nil
            newPerson.longitude = nil

            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func cancel() {
            image = nil
            newPerson.image = nil
            newPerson.name = ""
        }
    }
}
