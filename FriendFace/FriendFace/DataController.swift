//
//  DataController.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/25/23.
//

import CoreData
import Foundation

class DataContoller: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFace")

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
