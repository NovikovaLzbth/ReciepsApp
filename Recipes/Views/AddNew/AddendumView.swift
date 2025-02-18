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
    
    init(imageStorage: ImageStorage) {
           _viewModel = StateObject(wrappedValue: AddendumViewModel(imageStorage: imageStorage))
       }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView (.vertical) {
                    VStack {
                        VStack {
                            Label("", systemImage: "photo.badge.plus")
                                .foregroundStyle(.gray)
                                .scaleEffect(2)
                                .padding(16)
                            PhotosPicker("Выбрать фото", selection: $pickerItem, matching: .images)
                            selectedImage?
                                .resizable()
                                .scaledToFit()
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
                    .navigationBarTitle(Text("Новый рецепт"))
                }
            }
        }
    }
}
