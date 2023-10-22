//
//  Prospect.swift
//  HotProspects
//
//  Created by ADEBOLA AKEREDOLU on 10/18/23.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    var formattedDate: String {
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        return format.string(from: dateAdded)
    }

    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    @Published var sortStyle = sortStyles.mostRecent
    let saveKey = "SavedData"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

    enum sortStyles {
        case name, mostRecent
    }

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                sort(sortStyle)
                return
            }
        }

        people = []
    }

    private func save() {
        if let data = try? JSONEncoder().encode(people) {
            do {
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        } else {
            print("Failed to endcode data")
        }
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        sort(sortStyle)
        save()
    }

    func delete(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func sort(_ newSortStyle: sortStyles) {
        objectWillChange.send()
        people.sort { person1, person2 in
            if newSortStyle == .mostRecent {
                return person1.dateAdded > person2.dateAdded
            } else {
                return person1.name < person2.name
            }
        }
        sortStyle = newSortStyle
    }
}
