//
//  FavView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

struct FavView: View {
    let favoriteImages: Set<UUID>
    
    let allImages: [Item]
    
    let colomns = [
        GridItem(.fixed(190), spacing: 8),
        GridItem(.fixed(190), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    VStack {
                        LazyVGrid(columns: colomns, alignment: .center) {
                            ForEach(allImages.filter { favoriteImages.contains($0.uuid!) }, id: \.self) { item in
                                if let imageData = item.image, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 190, height: 220)
                                        .clipShape(CustomRoundedShape())
                                }
                            }
                        }
                    }
                    .onAppear {
                        let favoriteUUIDs = favoriteImages.map { $0.uuid }
                        print("Сохраненные изображения в избранном: \(favoriteUUIDs)")
                    }
                }
            }
            .navigationTitle("Избранное")
            .toolbar {
                Button {
                    // Действие для кнопки "trash"
                } label: {
                    Image("Корзина")
                }
            }
        }
    }
}


