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
    @EnvironmentObject var navigation : NavigationManager
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
               cartButton
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
            ProductDetailView(productID: product.id)
        }
    }
    
    @ViewBuilder
    var cartButton: some View {

        if quantity == 0 {

            Button {
                cartVM.addProduct(product)
            } label: {

                Text("Add to Cart")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(AppColors.accent)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

        } else {

            HStack {

                Button {
                    cartVM.removeProduct(product)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(AppColors.primary)
                }

                Spacer()

                Text("\(quantity)")
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.textPrimary)

                Spacer()

                Button {
                    cartVM.addProduct(product)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(AppColors.primary)
                }
            }
            .font(.title3)
            .padding(.vertical, 4)
        }
    }
}
