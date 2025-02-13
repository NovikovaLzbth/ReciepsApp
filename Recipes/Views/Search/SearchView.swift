//
//  SearchView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView (.vertical) {
                    VStack {
                        Text ("")
                    }
                    .navigationBarTitle(Text("Поиск"))
                }
            }
            
        }
        .searchable(text: $searchText, prompt: "Найти")
    }
}
