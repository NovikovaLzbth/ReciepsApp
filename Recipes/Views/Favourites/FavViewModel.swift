//
//  FavViewModel.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

final class FavViewModel: ObservableObject {
    
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
}
