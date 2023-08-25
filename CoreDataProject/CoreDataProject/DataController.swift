//
//  DataController.swift
//  CoreDataProject
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import Foundation

import CoreData
import Foundation

class DataContoller: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print ("Core Data failed to load: \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
