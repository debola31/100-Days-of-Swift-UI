//
//  Model.swift
//  CupcakeCorner
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    @Published var help = "Sule"

    enum CodingKeys: CodingKey {
        case name
        case help
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        help = try container.decode(String.self, forKey: .help)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(help, forKey: .help)
    }
}

func loadData() async -> [Result] {
    var results = [Result]()
    
    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
        print("Invalid URL")
        return []
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            results = decodedResponse.results
            return results
        }
    } catch {
        print("Invalid data")
    }
    return []
}
