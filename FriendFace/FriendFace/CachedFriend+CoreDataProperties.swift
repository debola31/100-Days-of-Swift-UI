//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/25/23.
//
//

import CoreData
import Foundation

public extension CachedFriend {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged var name: String?
    @NSManaged var id: UUID?
    @NSManaged var users: NSSet?

    var wrappedId: UUID {
        id ?? UUID()
    }

    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedUsers: [CachedUser] {
        let set = users as? Set<CachedUser> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for users

public extension CachedFriend {
    @objc(addUsersObject:)
    @NSManaged func addToUsers(_ value: CachedUser)

    @objc(removeUsersObject:)
    @NSManaged func removeFromUsers(_ value: CachedUser)

    @objc(addUsers:)
    @NSManaged func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged func removeFromUsers(_ values: NSSet)
}

extension CachedFriend: Identifiable {}
