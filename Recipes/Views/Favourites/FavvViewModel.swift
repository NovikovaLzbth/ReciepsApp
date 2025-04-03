//
//  FavvViewModel.swift
//  Recipes
//
//  Created by Елизавета on 24.03.2025.
//

import SwiftUI

final class FavvViewModel: ObservableObject {
    @Published var likedImages: [Item] = []
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
        fetchLikedImages()
    }
    
    func fetchLikedImages() {
        let allImages = storage.fetchImages()
        likedImages = allImages.filter { $0.isLiked }
    }
    
    func save(item: Item) {
        storage.saveToCoreData(item: item)
    }
}
