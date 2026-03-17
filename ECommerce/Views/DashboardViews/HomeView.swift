//
//  HomeView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//



import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var cartVM: CartViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        
        
        ScrollView {
            
            LazyVGrid(columns: columns, spacing: 16) {
                
                ForEach(homeVM.filteredProducts) { product in
                  
                        ProductCard(product: product)
                    
                }
                
                if homeVM.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding()
        }
      
        .navigationTitle("Products")
        
        .task {
            await homeVM.loadProducts()
        }
    }
}




#Preview {
    HomeView()
    
}
