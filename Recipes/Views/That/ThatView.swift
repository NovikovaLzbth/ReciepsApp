//
//  ThatView.swift
//  Recipes
//
//  Created by Елизавета on 21.02.2025.
//

import SwiftUI

struct ThatView: View {
    @StateObject private var viewModel: ThatViewModel
    
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
                HStack {
                    if let imageData = image.image,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}
