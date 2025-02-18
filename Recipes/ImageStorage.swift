//
//  ImageStorage.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

final class ImageStorage: ObservableObject {
    
    private let persistenceController: PersistenceController
    private var context: NSManagedObjectContext {
        persistenceController.viewContext
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func saveImageData(_ imageData: Data) {
        let item = Item(context: context)
        item.image = imageData
        
        do {
            try context.save()
            print("Image saved successfully")
        } catch {
            print("Failed to save image: \(error)")
        }
    }
}

