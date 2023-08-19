//
//  BookwormApp.swift
//  Bookworm
//
//  Created by ADEBOLA AKEREDOLU on 8/19/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataContoller()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
