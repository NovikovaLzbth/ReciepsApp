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
    private let storage = Storage(persistenceController: PersistenceController.shared)

    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(storage)
        }
    }
}
