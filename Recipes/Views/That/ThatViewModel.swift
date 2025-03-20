//
//  ThatViewModel.swift
//  Recipes
//
//  Created by Елизавета on 21.02.2025.
//

import SwiftUI
import CoreData

final class ThatViewModel: ObservableObject {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
}
