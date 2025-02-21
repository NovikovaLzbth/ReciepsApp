//
//  AddendumViewModel.swift
//  Recipes
//
//  Created by Elizaveta on 15.02.2025.
//

import SwiftUI
import CoreData

struct Comm {
    var title: String?
    var descrip: String?
}

final class AddendumViewModel: ObservableObject {
    
    @Published var uiImage: UIImage?
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func saveImage() {
        guard let uiImage = uiImage else { return }
        
        storage.writeImage(uiImage: uiImage)
    }
    
    func addComment(objectID: NSManagedObjectID, comm: Comm) {
        storage.edit(objectID: objectID, comm: comm)
    }
}
