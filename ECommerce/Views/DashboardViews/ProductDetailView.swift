//
//  ItemDetailView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var orderVM: OrdersViewModel
    @State private var orderPlaced = false
    @Environment(\.dismiss) var dismiss
    
    let productID: Int
    var product: ProductModel?{
        homeVM.filteredProducts.first(where: { $0.id == productID })
    }
    var addToCart: (() -> Void)? = nil
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - Product Image
                ProductImageView(
                    url: product?.images.first ?? "",
                    height: 300
                )
                
                
                // MARK: - Title
                Text(product?.title ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                
                
                // MARK: - Price
                Text("$\(product?.price ?? 0.0, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(AppColors.accent)
                
                
                // MARK: - Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(String(format: "%.1f", product?.rating ?? 0.0))
                }
                
                
                // MARK: - Availability
                Text(product?.availabilityStatus ?? "")
                    .foregroundColor(product?.stock ?? 0 > 0 ? AppColors.primary : .red)
                
                
                // MARK: - Description
                Text(product?.description ?? "")
                    .foregroundColor(AppColors.textSecondary)
                
                
                Divider()
                
                
                // MARK: - Reviews
                if let reviews = product?.reviews, !reviews.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Customer Reviews")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        ForEach(reviews) { review in
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                HStack {
                                    
                                    Text(review.reviewerName)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 3) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text("\(review.rating, specifier: "%.1f")")
                                    }
                                }
                                
                                Text(review.comment)
                                
                                Text(review.date)
                                    .font(.caption)
                                    .foregroundColor(AppColors.textSecondary)
                                Divider()
                            }
                        }
                    }
                    
                    Divider()
                }
                
                
                // MARK: - Action Buttons
                HStack(spacing: 16) {
                
                    if let product = product{
                        CartButton(product: product)
                    }
                    
                    PrimaryButton(title: "Buy Now"){
                        orderVM.checkout(totalItems: 1, totalAmount: product?.price ?? 0)

                        orderPlaced = true

                        Task {
                            try? await Task.sleep(for: .seconds(1.5))
                            await homeVM.loadProducts()
                            orderPlaced = false
                        }
                    }
                   
                }
                Button("Close"){
                    dismiss()
                }
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .overlay {
            
            if orderPlaced {
                Text("Order placed successfully")
                    .foregroundColor(AppColors.textPrimary)
                    .background(AppColors.background)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .transition(.opacity)
                    .padding()

            }
        }
        .animation(.easeInOut, value: orderPlaced)
    }
}
