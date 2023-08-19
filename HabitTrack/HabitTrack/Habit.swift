//
//  Habit.swift
//  HabitTrack
//
//  Created by ADEBOLA AKEREDOLU on 8/18/23.
//

import Foundation

struct Habit: Identifiable, Equatable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var timesCompleted = 0

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class HabitList: ObservableObject {
    @Published var items: [Habit] {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.set(data, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                items = decodedHabits
                return
            }
        }
        items = []
    }
}
