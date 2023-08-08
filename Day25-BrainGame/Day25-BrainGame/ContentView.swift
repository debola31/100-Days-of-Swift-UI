//
//  ContentView.swift
//  Day25-BrainGame
//
//  Created by ADEBOLA AKEREDOLU on 8/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appMove = Moves.random()
    @State private var win = Bool.random()
    @State private var score = 0
    @State private var playerChoice = Moves.paper
    @State private var rounds = 0
    @State private var gameOver = false

    let maxRounds = 10
    var alertText: String {
        return "Game Over. Score: \(score)/\(maxRounds)"
    }

    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.largeTitle.bold())
            Spacer()
            appMove.image
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
            Spacer()
            Text("Goal: \(win ? "Win" : "Lose")")
                .font(.largeTitle)
            Spacer()
            HStack {
                Spacer()
                ForEach(Moves.allCases) { move in
                    Button {
                        pick(move)
                    } label: {
                        move.image
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 50)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
        .alert(alertText, isPresented: $gameOver) {
            Button("Reset", action: reset)
        }
    }

    func pick(_ move: Moves) {
        switch appMove {
        case .rock:
            if win {
                score += move == .paper ? 1 : 0
            } else {
                score += move == .scissors ? 1 : 0
            }

        case .paper:
            if win {
                score += move == .scissors ? 1 : 0
            } else {
                score += move == .rock ? 1 : 0
            }

        case .scissors:
            if win {
                score += move == .rock ? 1 : 0
            } else {
                score += move == .paper ? 1 : 0
            }
        }

        rounds += 1
        if rounds >= maxRounds {
            gameOver = true
            return
        }
        win.toggle()
        appMove.toggle()
    }

    func reset() {
        rounds = 0
        score = 0
        win = Bool.random()
        appMove = Moves.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
