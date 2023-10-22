//
//  ContentView.swift
//  HotProspects
//
//  Created by ADEBOLA AKEREDOLU on 10/17/23.
//

import SamplePackage
import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject var prospects = Prospects()
    let possibleNumbers = Array(1 ... 60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }.environmentObject(prospects)
    }
}

#Preview {
    ContentView()
}
