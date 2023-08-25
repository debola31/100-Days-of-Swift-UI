//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by ADEBOLA AKEREDOLU on 8/23/23.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataContoller()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
