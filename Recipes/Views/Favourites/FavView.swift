//
//  FavView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

struct FavView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.uuid, ascending: true)], animation: .default)
    private var images: FetchedResults<Item>
    
    @StateObject var viewModel: FavvViewModel
    
    let colomns = [
        GridItem(.fixed(190), spacing: 8),
        GridItem(.fixed(190), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical) {
                    VStack {
                        LazyVGrid(columns: colomns, alignment: .center) {
                            ForEach(viewModel.likedImages, id: \.self) { item in
                                if let imageData = item.image,
                                   let uiImage = UIImage(data: imageData),
                                   let itemId = item.uuid,
                                   let title = item.title,
                                   let date = item.date {
                                    VStack {
                                        ZStack {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 190, height: 220)
                                                .clipShape(CustomRoundedShape())
                                            
                                            createHeartView(item: item, itemId: itemId)
                                        }
                                        
                                        Text(title)
                                            .padding(.leading, 7)
                                            .foregroundStyle(.black)
                                            .padding(.bottom, 3)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .fontWeight(.medium)
                                        
                                        Text("\(dateAndTime(date))")
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 5)
                                    }
                                    .background(Color.white)
                                    .cornerRadius(18)
                                    .padding(.bottom, 13)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Избранное"))
                .toolbar {
                    Button {
                        
                    } label: {
                        Image("Корзина")
                    }
                }
                .refreshable {
                    viewModel.fetchLikedImages()
                }
            }
            .background((Color.colorBG).ignoresSafeArea(.all))
        }
    }
    private func dateAndTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    private func createHeartView(item: Item, itemId: UUID) -> some View {
        Image(item.isLiked ? "зеленое сердце" : "сердце")
            .onTapGesture {
                if let index = images.firstIndex(where: { $0.uuid == itemId }) {
                    images[index].isLiked.toggle()
                    viewModel.save(item: images[index])
                    viewModel.fetchLikedImages()
                }
            }
            .scaleEffect(0.5)
            .position(x: 165, y: 25)
    }
}


