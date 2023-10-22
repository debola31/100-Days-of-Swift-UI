//
//  ContentView.swift
//  Flashzilla
//
//  Created by ADEBOLA AKEREDOLU on 10/18/23.
//

import CoreHaptics
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @StateObject var cardSet = CardSet()
    @State private var timeRemaining = 100
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func resetCards() {
        timeRemaining = 100
        isActive = true
        cardSet.loadData()
        if cardSet.isEmpty {
            cardSet.cards = Card.genExamples(count: 2)
        }
    }

    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())

                ZStack {
                    ForEach(cardSet.cards) { card in
                        if let index = cardSet.cards.firstIndex(where: { $0.id == card.id }) {
                            CardView(card: card) {
                                withAnimation {
                                    cardSet.removeCard(at: index)
                                    if cardSet.isEmpty {
                                        isActive = false
                                    }
                                }
                            } replace: {
                                withAnimation {
                                    cardSet.returnCard(card)
                                }
                            }
                            .stacked(at: index, in: cardSet.count)
                            .allowsHitTesting(index == cardSet.count - 1)
                            .accessibilityHidden(index < cardSet.count - 1)
                        }
                    }
                }.allowsHitTesting(timeRemaining > 0)

                if cardSet.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                cardSet.removeCard(at: cardSet.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            withAnimation {
                                cardSet.removeCard(at: cardSet.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }.onReceive(timer) { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cardSet.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
                .environmentObject(cardSet)
        }
        .onAppear(perform: resetCards)
    }
}

#Preview {
    ContentView()
}
