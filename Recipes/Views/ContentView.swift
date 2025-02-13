//
//  ContentView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
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
