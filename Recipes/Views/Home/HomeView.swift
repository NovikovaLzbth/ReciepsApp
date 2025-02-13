//
//  HomeView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ScrollView(.vertical) {
                    }
                }
                ZStack {
                    NavigationLink(destination: AddendumView(), label: {
                        Label("", systemImage: "plus.circle.dashed")
                            .scaleEffect(2.8)
                            .colorMultiply(.black)
                            .position(x: 340, y: 220)
                    })
                }
            }
            .navigationBarTitle(Text("Все рецепты"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Menu("Сортировать") {
                            Button("Без сортировки", action: {})
                            
                            Button("", action: {})
                            
                            Button("По дате", action: {})
                        }
                        
                        Button("Удалить все", action: {})
                    } label: {
                        Label("", systemImage: "ellipsis")
                    }
                }
            }
        }
    }
}

