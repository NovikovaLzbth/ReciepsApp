//
//  ThatView.swift
//  Recipes
//
//  Created by Елизавета on 21.02.2025.
//

import SwiftUI

struct ThatView: View {
    @StateObject private var viewModel: ThatViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var image: Item = Item()
    
    init(
        storage: Storage,
        image: Item
    ) {
        _viewModel = StateObject(wrappedValue: ThatViewModel(storage: storage))
        self.image = image
    }
    
    var body: some View {
        HStack {
            ScrollView {
                VStack {
                    if let imageData = image.image,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 10)
                    }
                    
                    if let title = image.title {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Divider()
                        .padding(.horizontal, -60)
                        .padding(.vertical, 10)
                    
                    Text("Список ингредиентов:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.leading, 25)
                    
                    if let descrip = image.descrip {
                        Text(descrip)
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.darkGray, lineWidth: 1)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                    }
                    
                    if let date = image.date {
                        Text("\(dateAndTime(date))")
                            .foregroundColor(.gray)
                            .padding(.bottom, 16)
                    }
                }
            }
        }
        .toolbar {
            Button {
                viewModel.delete(image: image)
                
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Label("", image: "Корзина")
                    .foregroundStyle(.darkGray)
            }
        }
        .background((Color.colorBG).ignoresSafeArea(.all))
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
