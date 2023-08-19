//
//  DataController.swift
//  Bookworm
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import CoreData
import Foundation

class DataContoller: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print ("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
