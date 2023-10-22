//
//  Location.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/17/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static let example = Location(id: UUID(), latitude: 51.501, longitude: -0.141)

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
