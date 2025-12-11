//
//  ContentView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData

struct CategoriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var nm: NetworkManager
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        List {
            Button {
                navigation.navigate(to: .category(K.Category.beauty))
            } label: {
                CategoryRowView(title: "Beauty Products", category: K.Category.beauty)
            }
            Button {
                navigation.navigate(to: .category(K.Category.furniture))
            } label: {
                CategoryRowView(title: "Furniture", category: K.Category.furniture)
            }
            Button {
                navigation.navigate(to: .category(K.Category.fragrance))
            } label: {
                CategoryRowView(title: "Fragrance", category: K.Category.fragrance)
            }
            Button {
                navigation.navigate(to: .category(K.Category.grocery))
            } label: {
                CategoryRowView(title: "Groceries", category: K.Category.grocery)
                CategoryRowView(title: "Groceries", category: K.Category.grocery)
            }
        }
        .navigationTitle(Text("Categories"))
    }
}

#Preview {
    CategoriesView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
