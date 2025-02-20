//
//  HomeView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    @State private var searchText = ""
    
    init(imageStorage: ImageStorage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(imageStorage: imageStorage))
    }
    
    let colomn = [
        GridItem(.fixed(160)),
        GridItem(.fixed(160))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    NavigationLink {
                        AddendumView(imageStorage: viewModel.imageStorage, fieldValueTitle: "", fieldValueDescrip: "")
                    } label: {
                        Label("", systemImage: "plus.circle.dashed")
                            .scaleEffect(2.5)
                            .foregroundStyle(.satadcolor)
                            
                    }
                    .frame(width: 100, height: 90)
                    .position(x: 345, y: 530)
                    .zIndex(1)
                    
                    ScrollView(.vertical) {
                        Image("icon")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(width: 300, height: 300)
                            .padding(.top, 120)
//                        LazyVGrid(columns: colomn, alignment: .center) {
//                            
//                        }
                    }
                }
            }
            .navigationBarTitle(Text("Все рецепты"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Menu("Сортировать") {
                            Button("По дате", action: {})
                            
                            Button("Без сортировки", action: {})
                        }
                        
                        Button("Удалить все", action: {})
                    } label: {
                        Image("Menu")
                    }
                }
            }
        }
    }
}

