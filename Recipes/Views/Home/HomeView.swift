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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.uuid, ascending: true)], animation: .default)
    private var images: FetchedResults<Item>
    
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(storage: storage))
    }
    
    let colomns = [
        GridItem(.fixed(160)),
        GridItem(.fixed(160))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    NavigationLink {
                        AddendumView(storage: viewModel.storage, fieldValueTitle: "", fieldValueDescrip: "")
                    } label: {
                        Label("", systemImage: "plus.circle.dashed")
                            .scaleEffect(2.5)
                            .foregroundStyle(.gray)
                        
                    }
                    .frame(width: 100, height: 90)
                    .position(x: 345, y: 530)
                    .zIndex(1)
                    
                    ScrollView(.vertical) {
                        if images.isEmpty {
                            // Показать иконку, если изображений нет
                            Image("icon")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(width: 300, height: 300)
                                .padding(.top, 120)
                        } else {
                            // Показать изображения из базы данных
                            LazyVGrid(columns: colomns, alignment: .center) {
                                ForEach(images, id: \.self) { item in
                                    if let imageData = item.image {
                                        if let uiImage = UIImage(data: imageData) {
                                            VStack {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(10)
                                                    .frame(width: 150, height: 150)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
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
                            
                            Button("Удалить все", action: viewModel.deleteAll)
                        } label: {
                            Image("Menu")
                        }
                    }
                }
            }
        }
    }
}
