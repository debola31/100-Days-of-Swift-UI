//
//  ContentView.swift
//  Day95
//
//  Created by ADEBOLA AKEREDOLU on 10/20/23.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var die = Die.example
    @State private var dieSize: Die.Sides = .six
    @State private var records = [Record]()
    let savedKeyString = "DiceRoll"
    let rollTime = 15
    @State private var rollTimeRemaining = 15
//    var timer: Timer?
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var rolling = false
    @State private var feedback = UINotificationFeedbackGenerator()

    func rollDice() {
        rolling = false
        rollTimeRemaining = rollTime
        let result = Int.random(in: 1 ... die.sides.rawValue)
        die.value = result
        let record = Record(die: die)
        records.append(record)
        records.sort { $0.dateCreated > $1.dateCreated }
        save()
    }

    func clearRecords() {
        records = [Record]()
        save()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: savedKeyString) {
            if let decoded = try? JSONDecoder().decode([Record].self, from: data) {
                records = decoded
                return
            }
        }
        print("whatis")
        records = []
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(encoded, forKey: savedKeyString)
        } else {
            print("what")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.5)
                        .frame(width: 150, height: 150)
                    Text("\(die.value)")
                        .font(.largeTitle)

                    HStack {
                        Spacer()
                        Picker("Sides", selection: $dieSize) {
                            ForEach(Die.Sides.allCases) { side in
                                Text("\(side.rawValue) sides")
                                    .tag(side)
                            }
                        }
                        .onChange(of: dieSize) { _ in
                            die.sides = dieSize
                        }
                        .padding([.horizontal, .trailing], 10)
                    }
                }
                .padding(.vertical)
                .onReceive(timer, perform: { _ in
                    feedback.prepare()
                    if rolling {
                        if rollTimeRemaining > 0 {
                            rollTimeRemaining -= 1
                            die.value = Int.random(in: 1 ... die.sides.rawValue)
                        } else {
                            rollDice()
                            feedback.notificationOccurred(.success)
                        }
                    }

                })

                Button("Roll Dice!") {
                    rolling = true
                }
                .disabled(rolling)
                .foregroundStyle(.white)
                .padding()
                .background(rolling ? Color(.gray) : Color(.blue))
                .opacity(rolling ? 0.7 : 1)
                .clipShape(Capsule())

                List {
                    Section("Previous Rolls") {
                        Button("Clear Records", action: clearRecords)
                            .foregroundStyle(records.isEmpty ?.gray : .blue)
                            .disabled(records.isEmpty)

                        ForEach(records) { record in
                            Text("\(record.die.value) / \(record.die.sides.rawValue)")
                        }
                    }
                }
                .onAppear(perform: loadData)
                .scrollContentBackground(.hidden)
                .background(.white)
            }.navigationTitle("Dice Roll")
        }
    }
}

#Preview {
    ContentView()
}
