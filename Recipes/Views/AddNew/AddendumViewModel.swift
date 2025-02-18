//
//  AddendumViewModel.swift
//  Recipes
//
//  Created by Elizaveta on 15.02.2025.
//

import SwiftUI
import CoreData

final class AddendumViewModel: ObservableObject {

    @Published var uiImage: UIImage?
    
    let imageStorage: ImageStorage
    
    init(imageStorage: ImageStorage) {
        self.imageStorage = imageStorage
    }
    
    func saveImage(_ imageData: Data) {
        imageStorage.saveImageData(imageData)
    }
}
