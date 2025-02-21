//
//  ContentView.swift
//  Recipes
//
//  Created by Elizaveta on 13.02.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var storage: Storage
    
    @State var selectedTab = "Все рецепты"
    
    let tabs = ["Поиск", "Все рецепты", "Избранное"]
    
    //Сокрытие TabBar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                SearchView()
                    .tag("Поиск")
                HomeView(storage: storage)
                    .tag("Все рецепты")
                FavView()
                    .tag("Избранное")
            }
            
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    TabBarItem(tab: tab, selected: $selectedTab)
                }
            }
            .padding(10)
            .background(Color.colorTabBar)
            .clipShape(Capsule())
        }
    }
}

//структура для кастома TabBar
struct TabBarItem: View {
    @State var tab: String
    
    @Binding var selected: String
    
    var body: some View {
        ZStack {
            Button {
                withAnimation(.bouncy()) {
                    selected = tab
                }
            } label: {
                Image(tab)
                    .resizable()
                    .frame(width: 22, height: 22)
                if selected == tab {
                    Text(tab)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.black)
                }
            }
        }
        .opacity(selected == tab ? 1 : 0.5)
        .padding(.horizontal, 10)
        .padding(.vertical, 12)
        .background(selected == tab ? .white : .colorTabBar)
        .clipShape(Capsule())
    }
}
