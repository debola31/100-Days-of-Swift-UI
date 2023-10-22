//
//  Die.swift
//  Day95
//
//  Created by ADEBOLA AKEREDOLU on 10/20/23.
//

import Foundation

struct Die: Codable {
    enum Sides: Int, CaseIterable, Identifiable, Codable {
        var id: Int {
            return self.rawValue
        }

        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
    }

    var sides: Sides
    var value: Int = 1
    var finishedRolling = false

    static let example = Die(sides: .six)
}

struct Record: Identifiable, Codable {
    var id = UUID()
    var dateCreated = Date()
    var die: Die
}
