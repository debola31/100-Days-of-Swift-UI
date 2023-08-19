//
//  ContentView.swift
//  Moonshot
//
//  Created by ADEBOLA AKEREDOLU on 8/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var listInsteadOfGrid = false
    let astronauts : [String:Astronaut] = Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")
    var columns : [GridItem] {
        [GridItem(.adaptive(minimum: listInsteadOfGrid ? .infinity : 150))]
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    VStack {
                                        Image(mission.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .padding()
                                        
                                        VStack {
                                            Text(mission.displayName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text(mission.formattedLaunchDate)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.5))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                        
                                    }
                                }
                            }
                        }.padding([.horizontal, .bottom])
                    }
                    .preferredColorScheme(.dark)
                }
                .navigationTitle("Moonshot")
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
                .toolbar {
                    Button(listInsteadOfGrid ? "Grid View" : "List View") {
                        listInsteadOfGrid.toggle()
                    }
                }
            }
        }
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String, _ instance: Int) {
        print("Creating a new CustomText \(instance)")
        self.text = text
    }
}
