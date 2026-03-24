//
//  ItemsGridView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI

struct CategoryItemsView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    let category: String
    
    var categoryProducts: [ProductModel] {
        homeVM.products.filter{$0.category == self.category}
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 16) {
                
                ForEach(categoryProducts) { product in
                    NavigationLink {
                        ProductDetailView(productID: product.id)
                    } label: {
                        ProductCard(product: product)
                    }
                }
                
                if homeVM.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
      
        .navigationTitle(category)
        
    }
}

#Preview {
    CategoryItemsView(category: K.Category.beauty )
}
