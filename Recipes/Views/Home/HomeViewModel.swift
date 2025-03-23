//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var sortType: SortType = .defaultOrder
    
    enum SortType {
        case defaultOrder
        case byName
        case byDate
    }
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func deleteAll() {
        storage.deleteAll()
    }
    
    func save(item: Item) {
        storage.saveToCoreData(item: item)
    }
    
    func fetch() {
        storage.fetchImages()
    }
}


