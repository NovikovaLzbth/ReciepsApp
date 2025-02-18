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
                VStack {
                    ScrollView(.vertical) {
//                        if viewModel.url != nil {
//                            Image("pngwing.png")
//                                .resizable()
//                                .scaledToFit ()
//                        } else {
//                            LazyVGrid(columns: colomn, alignment: .center) {
//                                if let image = viewModel.uiImage {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .cornerRadius(10)
//                                        .overlay{
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(.black, lineWidth: 3)
//                                        }
//                                        .padding(16)
//                                }
//                            }
//                        }
                    }
                }
                ZStack {
                    NavigationLink {
                        AddendumView(imageStorage: viewModel.imageStorage)
                    } label: {
                        Label("", systemImage: "plus.circle.dashed")
                            .scaleEffect(2.8)
                            .foregroundStyle(.gray)
                            .position(x: 340, y: 220)
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
                        Label("", systemImage: "ellipsis")
                    }
                }
            }
        }
    }
}

