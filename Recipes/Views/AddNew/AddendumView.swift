//
//  AddendumView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import PhotosUI
import CoreData

struct AddendumView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel: AddendumViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State var fieldValueTitle: String
    @State var fieldValueDescrip: String
    @State private var isEdit = false
    
    var image: Item?
    
    @FocusState private var nameIsFocused: Bool
    
    init(storage: Storage,
         fieldValueTitle: String,
         fieldValueDescrip: String,
         image: Item?
    ) {
        _viewModel = StateObject(wrappedValue: AddendumViewModel(storage: storage))
        self.fieldValueTitle = fieldValueTitle
        self.fieldValueDescrip = fieldValueDescrip
        self.image = image
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView (.vertical) {
                    VStack {
                        VStack {
                            
                            // Условие для проверки, выбрал ли пользователь изображение
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                VStack {
                                    Label("", systemImage: "photo.badge.plus")
                                        .foregroundStyle(.gray)
                                        .scaleEffect(2)
                                        .padding(16)
                                    PhotosPicker("Выбрать фото", selection: $pickerItem, matching: .images)
                                }
                                .padding(.vertical, 90)
                                .padding(.horizontal, 130)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.darkGray, lineWidth: 1)
                                }
                                .onChange(of: pickerItem) { newItem in
                                    Task {
                                        if let item = newItem {
                                            if let imageData = try await item.loadTransferable(type: Data.self) {
                                                selectedImage = UIImage(data: imageData)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        
                        Divider()
                            .padding(.horizontal, 60)
                            .padding(.vertical, 18)
                        
                        //Комментарий
                        VStack {
                            TextField("Название", text: $fieldValueTitle, onCommit: {
                                let comm = Comm(
                                    title: fieldValueTitle
                                )
                            })
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.darkGray, lineWidth: 1)
                            }
                            .padding(.bottom, 3)
                            
                            TextField("Список ингредиентов", text: $fieldValueDescrip, onCommit: {
                                let comm = Comm(
                                    descrip: fieldValueDescrip
                                )
                            })
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.darkGray, lineWidth: 1)
                            }
                        }
                        .focused($nameIsFocused)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 27)
                        
                        Button("Сохранить",
                               action: {
                            // Создание генератора обратной связи
                            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                            feedbackGenerator.prepare() // Подготовка генератора
                            feedbackGenerator.impactOccurred() // Вибрация при нажатии
                            
                            viewModel.uiImage = selectedImage
                            
                            let comm = Comm(
                                title: fieldValueTitle,
                                descrip: fieldValueDescrip
                            )
                            
                            viewModel.loadImage(comm: comm)
                            
                            presentationMode.wrappedValue.dismiss()
                        
                        })
                        .foregroundStyle(.darkGray)
                        .padding(20)
                    }
                }
            }
            .background(Color.colorBG)
        }
    }
}

