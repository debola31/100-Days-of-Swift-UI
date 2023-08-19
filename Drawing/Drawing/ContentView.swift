//
//  ContentView.swift
//  Drawing
//
//  Created by ADEBOLA AKEREDOLU on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var rows = 4
    @State private var columns = 4
    @State private var lineWidth = 5.0
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: colorCycle)
                .drawingGroup()

            Slider(value: $colorCycle)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
