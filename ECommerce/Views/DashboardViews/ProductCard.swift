//
//  ProductCard.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 13/03/26.
//
import SwiftUI

struct ProductCard: View {

    @State var product: ProductModel
    @EnvironmentObject var cartVM: CartViewModel
    @State var showDetail = false
    
    
    var quantity: Int {
           cartVM.checkQuantity(for: product)
    }

    
    var body: some View {
        
        VStack(alignment: .leading) {
            ProductImageView(url: product.images.first ?? "")
                 // Product Title)
            Text(product.title)
                .font(.headline)
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(2)
            
            
            
            // Price
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(AppColors.accent)
            
            
            // Availability
            Text(product.availabilityStatus)
                .font(.caption)
                .foregroundColor(product.stock > 0 ? AppColors.primary : .red)
            
            
            // Add to Cart Button
            CartButton(product: product)
            Button{
                showDetail = true
            }label: {
                Text("Details")
            }
        }
        .padding()
        .background(AppColors.card)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 4)
        // FULL SCREEN PRESENTATION
        .sheet(isPresented: $showDetail) {
            ProductDetailView(productID: product.id){
                cartVM.addProduct(product)
            }
        }
    }
   
}
