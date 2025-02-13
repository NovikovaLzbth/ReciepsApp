//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    private let imageStorage: ImageStorage
    
    init(imageStorage: ImageStorage) {
        self.imageStorage = imageStorage
    }
    
}


