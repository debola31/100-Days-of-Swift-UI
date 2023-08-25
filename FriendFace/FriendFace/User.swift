//
//  User.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/23/23.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var age: Int
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friends]
}

struct Friends: Codable {
    var id: String
    var name: String
}
