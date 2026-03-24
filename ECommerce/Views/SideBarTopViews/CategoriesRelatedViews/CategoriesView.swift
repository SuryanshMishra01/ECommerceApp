//
//  ContentView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData

struct CategoriesView: View {
  
    @EnvironmentObject var homeVM: HomeViewModel
    

    var body: some View {
        VStack{
            HStack{
                NavigationLink{
                    CategoryItemsView(category: K.Category.fragrance)
                }label: {
                    CategoryCard(category: K.Category.fragrance)
                }
                NavigationLink{
                    CategoryItemsView(category: K.Category.furniture)
                }label: {
                    CategoryCard(category: K.Category.furniture)
                }
            }
            .padding()
            HStack{
                NavigationLink{
                    CategoryItemsView(category: K.Category.grocery)
                }label: {
                    CategoryCard(category: K.Category.grocery)
                }
                NavigationLink{
                    CategoryItemsView(category: K.Category.beauty)
                }label: {
                    CategoryCard(category: K.Category.beauty)
                }
            }
            .padding()
        }
        .padding()
        .navigationTitle("Categories")
    }
    
   
    
}

#Preview {
    CategoriesView()
}
