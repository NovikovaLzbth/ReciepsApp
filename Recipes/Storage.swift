//
//  ImageStorage.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

final class Storage: ObservableObject {
    
    private let persistenceController: PersistenceController
    private var context: NSManagedObjectContext {
        persistenceController.viewContext
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func writeImage(uiImage: UIImage) {
        guard let data = uiImage.pngData() else { return }
        let item = Item(context: context)
        
        item.image = data
        item.uuid = UUID()
        
        DispatchQueue.main.async {
            do {
                try self.context.save()
                print("Изображение сохранено")
            } catch {
                print("Failed to save image: \(error)")
            }
        }
    }
    
    func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Item"))
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let deleteRequestResult = try context.execute(deleteRequest) as? NSBatchDeleteResult
            guard let deletedPlaceIds = deleteRequestResult?.result as? [NSManagedObjectID] else {
                return
            }
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedPlaceIds], into: [context])
        } catch {
            print("Ошибка при удалении всех изображений: \(error.localizedDescription)")
        }
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

