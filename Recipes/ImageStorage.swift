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
    
    func deleteImage(_ imageData: Data) {
        
    }
    
    func edit(objectID: NSManagedObjectID?, comm: Comm) {
        guard
            let objectID = objectID,
            var image = try? self.context.existingObject(with: objectID) as? Item
        else {
            return
        }
        
        if let title = comm.title {
            image.title = title
        }
        
        if let descrip = comm.descrip {
            image.descrip = descrip
        }
        
        do {
            try self.context.save()
            print("комментарий добавлен")
            print(image)
        } catch {
            print("Ошибка")
        }
    }
}

