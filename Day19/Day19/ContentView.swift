//
//  ContentView.swift
//  Day19
//
//  Created by ADEBOLA AKEREDOLU on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var categorySelection = 0
    @State private var input = 0.0
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @FocusState private var inputIsFocused: Bool

    let categories = ["Temperature", "Length", "Time", "Volume"]
    let units = ["Temperature": [UnitTemperature.celsius, UnitTemperature.kelvin, UnitTemperature.fahrenheit],
                 "Length": [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
                 "Time": [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours, UnitDuration.days],
                 "Volume": [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]]

    var unitOptions: [Dimension] {
        let category = categories[categorySelection]
        let options = units[category, default: []]
        return options
    }

    var formatter: MeasurementFormatter {
        let format = MeasurementFormatter()
        format.unitStyle = .long
        return format
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Category", selection: $categorySelection) {
                        ForEach(0 ..< categories.count, id: \.self) {
                            Text(categories[$0])
                        }
                    }
                }

                Section("Input") {
                    TextField(value: $input, format: .number) {
                        Text("Enter Input Value")
                    }
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)

                    Picker("Unit", selection: $inputUnit) {
                        ForEach(0 ..< unitOptions.count, id: \.self) {
                            Text(formatter.string(from: unitOptions[$0]))
                        }
                    }
                }

                Section("Output") {
                    let inputIndex = inputUnit < unitOptions.count ?inputUnit :0
                    let inputValue = Measurement(value: input, unit: unitOptions[inputIndex])
                    let outputIndex = outputUnit < unitOptions.count ?outputUnit :0
                    let outputValue = inputValue.converted(to: unitOptions[outputIndex]).value
                    Text(outputValue, format: .number)
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(0 ..< unitOptions.count, id: \.self) {
                            Text(formatter.string(from: unitOptions[$0]))
                        }
                    }
                }
            }
            .navigationTitle("Day 19")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
