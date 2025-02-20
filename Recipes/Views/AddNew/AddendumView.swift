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
    
    @StateObject private var viewModel: AddendumViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State var fieldValueTitle: String
    @State var fieldValueDescrip: String
    @State private var isEdit = false
    
    @FocusState private var nameIsFocused: Bool
    
    init(imageStorage: ImageStorage,
         fieldValueTitle: String,
         fieldValueDescrip: String
    ) {
        _viewModel = StateObject(wrappedValue: AddendumViewModel(imageStorage: imageStorage))
        self.fieldValueTitle = fieldValueTitle
        self.fieldValueDescrip = fieldValueDescrip
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView (.vertical) {
                    VStack {
                        VStack {
                            
                            // Условие для проверки, выбрал ли пользователь изображение
                            if let selectedImage = selectedImage {
                                selectedImage
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                    }
                                    .padding(.top, 20)
                                    .padding(18)
                            } else {
                                VStack {
                                    Label("", systemImage: "photo.badge.plus")
                                        .foregroundStyle(.gray)
                                        .scaleEffect(2)
                                        .padding(16)
                                    PhotosPicker("Выбрать фото", selection: $pickerItem, matching: .images)
                                }
                                .padding(.vertical, 70)
                                .padding(.horizontal, 120)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                }
                                .padding(.top, 70)
                                .onChange(of: pickerItem) { newItem in
                                    Task {
                                        if let item = newItem {
                                            if let imageData = try await item.loadTransferable(type: Data.self) {
                                                selectedImage = Image(uiImage: UIImage(data: imageData)!)
                                                viewModel.saveImage(imageData)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 25)
                        
                        VStack {
                            VStack {
                                TextField("Название", text: $fieldValueTitle, onCommit: {
                                    let comm = Comm(
                                        title: fieldValueTitle
                                    )
                                })
                                .padding(16)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                }
                                .padding(.bottom, 10)
                                
                                TextField("Описание", text: $fieldValueDescrip, onCommit: {
                                    let comm = Comm(
                                        descrip: fieldValueDescrip
                                    )
                                })
                                .padding(16)
                                .frame(height: 100)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 1)
                                }
                            }
                            .focused($nameIsFocused)
                            .padding(16)
                        }
                    }
                }
                .navigationBarTitle(Text("Создать новый"))
            }
        }
    }
}

