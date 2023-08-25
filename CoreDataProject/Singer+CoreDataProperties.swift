//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by ADEBOLA AKEREDOLU on 8/21/23.
//
//

import CoreData
import Foundation

public extension Singer {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?

    internal var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    internal var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer: Identifiable {}
