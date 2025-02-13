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
                    Label("", systemImage: "house")
                }
            
            SearchView()
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            
            FavView()
                .tabItem {
                    Label("", systemImage: "heart")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
