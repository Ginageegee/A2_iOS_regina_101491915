//
//  A2_iOS_regina_101491915App.swift
//  A2_iOS_regina_101491915
//
//  Created by Gina Slonimsky  on 2026-04-08.
//

import SwiftUI
import CoreData

//entry point for app
@main
struct A2_iOS_regina_101491915App: App {
    
    //Creats a shared instance of core data controller (gives access to the data)
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView() //loads main screen
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
