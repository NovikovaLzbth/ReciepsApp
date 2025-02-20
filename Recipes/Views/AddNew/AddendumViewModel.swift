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
    
    let imageStorage: ImageStorage
    
    init(imageStorage: ImageStorage) {
        self.imageStorage = imageStorage
    }
    
    func saveImage(_ imageData: Data) {
        imageStorage.saveImageData(imageData)
    }
    
    func addComment(objectID: NSManagedObjectID, comm: Comm) {
        imageStorage.edit(objectID: objectID, comm: comm)
    }
}
