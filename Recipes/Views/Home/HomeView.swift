//
//  HomeView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ScrollView(.vertical) {
                        Text("Hello, World!")
                    }
                }
                ZStack {
                    NavigationLink(destination: AddendumView(), label: {
                        Label("", systemImage: "plus.square.dashed")
                            .scaleEffect(3)
                            .colorMultiply(.black)
                            .frame()
                    })
                }
            }
            .navigationBarTitle(Text("Меню"))
            
        }
        
    }
}

