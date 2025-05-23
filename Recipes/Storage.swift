//
//  ImageStorage.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

final class Storage: ObservableObject {
    
    @Published var favoriteImageIDs: Set<UUID> = []
    @Published var items: [Item]
    
    private let persistenceController: PersistenceController
    private var context: NSManagedObjectContext {
        persistenceController.viewContext
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        self.items = []
    }
    
    func saveImageWithComment(uiImage: UIImage, comm: Comm) {
        guard let data = uiImage.pngData() else { return }
        let item = Item(context: context)
        
        item.image = data
        item.uuid = UUID()
        item.date = Date()
                
        if let title = comm.title {
            item.title = title
        }
        
        if let descrip = comm.descrip {
            item.descrip = descrip
        }
        
        DispatchQueue.main.async {
            do {
                try self.context.save()
                print("Изображение и комментарий сохранены")
            } catch {
                print("Failed to save image and comment: \(error)")
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
    
    func delete(image: Item) {
        context.delete(image)
        
        do {
            try context.save()
        } catch {
            print("Ошибка удаления изображение")
        }
    }
    
    func fetchImages() -> [Item] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.uuid, ascending: true)]
        
        var images: [Item] = []
        
        do {
            images = try context.fetch(fetchRequest)
        } catch {
            print("Ошибка при загрузке изображений: \(error.localizedDescription)")
        }
        return images
    }
    
    func saveToCoreData(item: Item) {
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения в Core Data: \(error.localizedDescription)")
        }
    }
}

