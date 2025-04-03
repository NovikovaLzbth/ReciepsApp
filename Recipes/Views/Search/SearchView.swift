//
//  SearchView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @State private var searchText = ""
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.uuid, ascending: true)], animation: .default)
    private var images: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorBG.ignoresSafeArea()
                
                ScrollView(.vertical) {
                    VStack {
                        if viewModel.items.isEmpty {
                            
                        }
                        ForEach(viewModel.items, id: \.self) { item in
                            if let imageData = item.image,
                               let title = item.title,
                               let uiImage = UIImage(data: imageData) {
                                NavigationLink {
                                    ThatView(storage: viewModel.storage, image: item)
                                } label: {
                                    HStack {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 7)
                                        
                                        Text(title)
                                            .foregroundStyle(.black)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, -60)
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundStyle(.gray)
                                            .padding(.leading, -30)
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Найти")
            .navigationBarTitle(Text("Поиск"))
        }
        .onAppear {
            viewModel.fetchAllItems()
        }
        .onChange(of: searchText) { newValue in
            viewModel.searchItems(with: newValue)
            if newValue.isEmpty {
                // Очищение поисковой строки
                viewModel.items = []
            }
        }
    }
}
