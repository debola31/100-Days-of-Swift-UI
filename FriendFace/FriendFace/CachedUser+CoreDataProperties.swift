//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/25/23.
//
//

import CoreData
import Foundation

public extension CachedUser {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged var about: String?
    @NSManaged var address: String?
    @NSManaged var age: Int16
    @NSManaged var email: String?
    @NSManaged var isActive: Bool
    @NSManaged var name: String?
    @NSManaged var registered: Date?
    @NSManaged var tags: String?
    @NSManaged var id: UUID?
    @NSManaged var friends: NSSet?

    var wrappedId: UUID {
        id ?? UUID()
    }

    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedEmail: String {
        email ?? "Unknown"
    }

    var wrappedAddress: String {
        address ?? "Unknown"
    }

    var wrappedAbout: String {
        about ?? "Unknown"
    }

    var wrappedRegistered: Date {
        registered ?? Date.now
    }

    var wrappedTags: String {
        tags ?? ""
    }

    var wrappedFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for friends

public extension CachedUser {
    @objc(addFriendsObject:)
    @NSManaged func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged func removeFromFriends(_ values: NSSet)
}

extension CachedUser: Identifiable {}
