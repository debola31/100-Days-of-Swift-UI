//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by ADEBOLA AKEREDOLU on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            
            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Message", isPresented: $showingAlert) {
                Button("Ok") {}
            } message: {
                Text("Read this")
            }.foregroundColor(.primary)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
