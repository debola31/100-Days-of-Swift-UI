//
//  CardSet.swift
//  Flashzilla
//
//  Created by ADEBOLA AKEREDOLU on 10/19/23.
//

import Foundation

extension CardSet {
    var count: Int {
        cards.count
    }

    var isEmpty: Bool {
        cards.isEmpty
    }
}

class CardSet: ObservableObject {
    @Published var cards = [Card]()
    let savePath = FileManager.documentsDirectory.appendingPathComponent("FlashZilla")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }

    func addCard(_ card: Card) {
        cards.insert(card, at: 0)
        save()
    }

    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }

    func returnCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
            let newCard = Card(prompt: card.prompt, answer: card.answer)
            cards.insert(newCard, at: 0)
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }

    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
}
