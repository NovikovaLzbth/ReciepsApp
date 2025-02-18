//
//  ContentView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var imageStorage: ImageStorage
    
    var body: some View {
        TabView {
            HomeView(imageStorage: imageStorage)
                .tabItem {
                    Label("Все рецепты", systemImage: "house")
                }
            
            SearchView()
                .tabItem {
                    Label("Поиск", systemImage: "magnifyingglass")
                }
            
            FavView()
                .tabItem {
                    Label("Избранное", systemImage: "heart")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
