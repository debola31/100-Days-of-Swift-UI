//
//  Card.swift
//  Flashzilla
//
//  Created by ADEBOLA AKEREDOLU on 10/18/23.
//

import Foundation

struct Card: Codable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    static var examples: [Card] {
        var examples = [Card]()
        for _ in 0 ... 10 {
            examples.append(Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker"))
        }
        return examples
    }

    static func genExamples(count: Int) -> [Card] {
        var examples = [Card]()
        for _ in 0 ... count {
            examples.append(Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker"))
        }
        return examples
    }
}
