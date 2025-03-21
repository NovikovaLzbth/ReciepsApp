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
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    //Ограничение для заголовка
    private let characterLimit = 15
    
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
                                .padding(.horizontal, 120)
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
                        
                        //Комментарий
                        VStack {
                            ZStack{
                                Text("\(fieldValueTitle.count)/\(characterLimit)")
                                    .zIndex(1)
                                    .position(x: 315, y: 27)
                                    .foregroundStyle(.darkGray)
                                
                                TextField("Название", text: $fieldValueTitle)
                                //Ограничение для заголовка
                                .onChange(of: fieldValueTitle) { newValue in
                                    if fieldValueTitle.count > characterLimit {
                                        fieldValueTitle = String(fieldValueTitle.prefix(characterLimit))
                                    }
                                }
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.darkGray, lineWidth: 1)
                                }
                                .padding(.bottom, 3)
                            }
                            
                            Divider()
                                .padding(.horizontal, -60)
                                .padding(.vertical, 18)
                            
                            Text("Список ингредиентов:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding(.leading, 7)
                                
                            TextEditor(text: $fieldValueDescrip)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.darkGray, lineWidth: 1)
                                }
                                .frame(height: 400)
                        }
                        .focused($nameIsFocused)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 27)
                        
                        Button("Сохранить",
                               action: {
                            if fieldValueTitle.isEmpty || fieldValueDescrip.isEmpty {
                                alertMessage = "Пожалуйста, заполните все поля."
                                showAlert = true
                                return
                            }
                            
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
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Ошибка"),
                                  message: Text(alertMessage),
                                  dismissButton: .default(Text("OK")))
                        }
                        .foregroundStyle(.darkGray)
                        .padding(20)
                    }
                }
            }
            .background(Color.colorBG)
        }
    }
}

