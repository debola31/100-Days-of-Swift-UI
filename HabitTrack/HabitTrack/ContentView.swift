//
//  ContentView.swift
//  HabitTrack
//
//  Created by ADEBOLA AKEREDOLU on 8/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var newHabitTitle = ""
    @State private var newHabitDescription = ""
    @StateObject var habitList = HabitList()

    func addNewHabit(title: String, description: String) {
        let newHabit = Habit(title: title, description: description)
        habitList.items.append(newHabit)
    }

    var body: some View {
        NavigationView {
            List {
                Section("Add New Habit") {
                    TextField("Title", text: $newHabitTitle)
                        .autocorrectionDisabled()
                    TextField("Description", text: $newHabitDescription)
                        .autocorrectionDisabled()
                    Button("Add") {
                        addNewHabit(title: newHabitTitle, description: newHabitDescription)
                        newHabitTitle = ""
                        newHabitDescription = ""
                    }.disabled(newHabitTitle.count == 0 || newHabitDescription.count == 0)
                }

                Section("Habits") {
                    ForEach(habitList.items) { habit in
                        NavigationLink(habit.title) {
                            HabitView(habitList: habitList, habit: habit)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
