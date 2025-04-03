//
//  SearchViewModel.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var items: [Item] = []
    private var allImages: [Item] = [] // Добавлено для хранения всех изображений
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
        fetchAllItems()
    }
    
    func fetchAllItems() {
        allImages = storage.fetchImages()
        items = []
    }
    
    func searchItems(with query: String) {
        if query.isEmpty {
            self.items = []
        } else {
            let lowercasedQuery = query.lowercased()
            self.items = allImages.filter { item in
                guard let title = item.title else { return false }
                return title.lowercased().hasPrefix(lowercasedQuery)
            }
        }
    }
}

