//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by ADEBOLA AKEREDOLU on 8/21/23.
//
//

import CoreData
import Foundation

public extension Country {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged var fullName: String?
    @NSManaged var shortName: String?
    @NSManaged var candy: NSSet?

    var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }

    var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }

    var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted { $0.wrappedName < $1.wrappedName }
    }
}

// MARK: Generated accessors for candy

public extension Country {
    @objc(addCandyObject:)
    @NSManaged func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged func removeFromCandy(_ values: NSSet)
}

extension Country: Identifiable {}
