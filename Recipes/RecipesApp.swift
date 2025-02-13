//
//  RecipesApp.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

@main
struct RecipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
