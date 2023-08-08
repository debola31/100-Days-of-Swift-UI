//
//  Model.swift
//  Day25-BrainGame
//
//  Created by ADEBOLA AKEREDOLU on 8/7/23.
//

import Foundation
import SwiftUI

enum Moves: CaseIterable, Identifiable {
    var id: Self {
        return self
    }

    case rock, paper, scissors

    var image: Image {
        switch self {
        case .paper: return Image(systemName: "newspaper")
        case .rock: return Image(systemName: "globe.europe.africa")
        case .scissors: return Image(systemName: "scissors")
        }
    }

    static func random() -> Moves {
        return Self.allCases.randomElement()!
    }

    mutating func toggle() {
        self = Self.allCases.randomElement()!
    }
}
