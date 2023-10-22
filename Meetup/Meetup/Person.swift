//
//  Person.swift
//  Meetup
//
//  Created by ADEBOLA AKEREDOLU on 10/14/23.
//

import Foundation
import MapKit
import UIKit

struct Person: Identifiable, Comparable, Codable {
    var id = UUID()
    var name: String
    var image: UIImage?
    var latitude: Double?
    var longitude: Double?
    var location: Location? {
        guard let latitude = latitude else { return nil }
        guard let longitude = longitude else { return nil }
        return Location(latitude: latitude, longitude: longitude)
    }

    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)

        do {
            let imageData = try values.decode(Data.self, forKey: .image)
            image = UIImage(data: imageData)
            latitude = try values.decode(Double.self, forKey: .latitude)
            longitude = try values.decode(Double.self, forKey: .longitude)
        } catch {
            image = nil
            latitude = nil
            longitude = nil
        }
    }

    init(name: String, image: UIImage?) {
        self.name = name
        self.image = image
    }

    enum CodingKeys: String, CodingKey {
        case id, name, image, latitude, longitude
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if let latitude = latitude {
            try container.encode(latitude, forKey: .latitude)
        }

        if let longitude = longitude {
            try container.encode(longitude, forKey: .longitude)
        }

        if let image = image {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try container.encode(jpegData, forKey: .image)
            }
        }
    }

    static let example = Person(name: "Example", image: nil)
}
