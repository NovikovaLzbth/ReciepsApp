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
        GridItem(.fixed(190), spacing: 8),
        GridItem(.fixed(190), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    NavigationLink {
                        AddendumView(storage: viewModel.storage, fieldValueTitle: "", fieldValueDescrip: "", image: nil)
                    } label: {
                        Image(systemName: "plus.circle.dashed")
                            .scaleEffect(2.5)
                            .foregroundStyle(.darkGray)
                        
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Capsule())
                    .position(x: 345, y: 550)
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
                                ForEach(images.sorted {
                                    switch viewModel.sortType {
                                    case .byName:
                                        $0.title ?? "" < $1.title ?? ""
                                    case .byDate:
                                        $0.date ?? Date() > $1.date ?? Date()
                                    case .defaultOrder:
                                        false
                                    }
                                }, id: \.self) { item in
                                    if let imageData = item.image,
                                       let uiImage = UIImage(data: imageData),
                                       let itemId = item.uuid,
                                       let title = item.title,
                                       let date = item.date {
                                        NavigationLink {
                                            ThatView(storage: viewModel.storage, image: item)
                                        } label: {
                                            VStack {
                                                ZStack {
                                                    createImageView(uiImage: uiImage)
                                                    createHeartView(item: item, itemId: itemId)
                                                }
                                                
                                                Text(title)
                                                    .padding(.leading, 7)
                                                    .foregroundStyle(.black)
                                                    .padding(.bottom, 10)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .fontWeight(.medium)
                                                
                                                Text("\(dateAndTime(date))")
                                                    .foregroundColor(.gray)
                                                    .padding(.bottom, 5)
                                                
                                            }
                                            .background(Color.white)
                                            .cornerRadius(18)
                                            .padding(.bottom, 30)
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
                                Button("По дате", action: { viewModel.sortType = .byDate })
                                
                                Button("По имени", action: { viewModel.sortType = .byName })
                                
                                Button("Без сортировки", action: { viewModel.sortType = .defaultOrder })
                            }
                            
                            Button("Удалить все", action: viewModel.deleteAll)
                        } label: {
                            Image("Menu")
                        }
                    }
                }
            }
            .background((Color.colorBG).ignoresSafeArea(.all))
        }
    }
    
    private func createImageView(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 190, height: 220)
            .clipShape(CustomRoundedShape())
            .padding(.bottom, 10)
    }

    private func createHeartView(item: Item, itemId: UUID) -> some View {
        Image(item.isLiked ? "зеленое сердце" : "сердце")
            .onTapGesture {
                if let index = images.firstIndex(where: { $0.uuid == itemId }) {
                    images[index].isLiked.toggle()
                    viewModel.save(item: images[index])
                }
            }
            .scaleEffect(0.5)
            .position(x: 165, y: 25)
    }
    
    private func dateAndTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}

// Структура для прямоугольника с закругленными верхними углами
struct CustomRoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + 18))
        path.addArc(center: CGPoint(x: rect.minX + 18, y: rect.minY + 18), radius: 18, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - 18, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - 18, y: rect.minY + 18), radius: 18, startAngle: .degrees(270), endAngle: .degrees(360), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}
