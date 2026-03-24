//
//  CategoryCard.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/03/26.
//

import SwiftUI

struct CategoryCard: View {
    @EnvironmentObject var homeVM: HomeViewModel
    let category: String
    
    var firstProduct: ProductModel{
        homeVM.products.first(where: {category.lowercased() == $0.category.lowercased()}) ?? K.dummyProduct
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            ProductImageView(url: firstProduct.images.first ?? "", height: 250)
            // Product Title)
            Text(firstProduct.category)
                .font(.headline)
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(2)
            
            
            
        }
        .padding()
        .background(AppColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 4)
      
    }
   
}
