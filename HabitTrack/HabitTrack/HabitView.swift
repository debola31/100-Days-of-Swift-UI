//
//  HabitView.swift
//  HabitTrack
//
//  Created by ADEBOLA AKEREDOLU on 8/18/23.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habitList: HabitList
    @State var habit: Habit

    var body: some View {
        VStack {
            Text(habit.title)
                .font(.largeTitle.bold())
            Text(habit.description)
            Spacer()
            HStack {
                VStack {
                    Text("Times Completed")
                    Text(habit.timesCompleted, format: .number)
                }

                VStack {
                    Text("Record Activity")
                    Button {
                        habit.timesCompleted += 1
                        if let index = habitList.items.firstIndex(where: { $0.id == habit.id }) {
                            habitList.items[index] = habit
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            Spacer()
            Spacer()
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habitList: HabitList(), habit: Habit(title: "Title", description: "Description"))
    }
}
