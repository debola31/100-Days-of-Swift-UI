//
//  ContentView.swift
//  Day21
//
//  Created by ADEBOLA AKEREDOLU on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scroreTitle = ""
    @State private var score = 0
    @State private var alertText = ""
    @State private var rounds = 0
    @State private var gameOver = false
    let maxRounds = 3
    var finalText: String {
        return "Game Over, Final Score: \(score)/\(maxRounds)."
    }

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0 ... 2)
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .customized(color: .white)

                Spacer()

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0 ..< 3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(image: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scroreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertText)
        }
        .alert(finalText, isPresented: $gameOver) {
            Button("Restart", action: reset)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scroreTitle = "Correct"
            score += 1
            alertText = "Your score: \(score)"
        } else {
            scroreTitle = "Wrong"
            score -= score < 1 ? 0 : 1
            alertText = """
            Wrong! Thats the flag of \(countries[number]).
            Your score: \(score)
            """
        }
        rounds += 1
        if rounds >= maxRounds {
            gameOver = true
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }

    func reset() {
        score = 0
        rounds = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
