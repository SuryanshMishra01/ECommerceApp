//
//  ItemDetailView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var homeVM: HomeViewModel
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
                    .foregroundColor(.orange)
                
                
                // MARK: - Rating
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(String(format: "%.1f", product?.rating ?? 0.0))
                }
                
                
                // MARK: - Availability
                Text(product?.availabilityStatus ?? "")
                    .foregroundColor(product?.stock ?? 0 > 0 ? .green : .red)
                
                
                // MARK: - Description
                Text(product?.description ?? "")
                    .foregroundColor(.secondary)
                
                
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
                                    .foregroundColor(.secondary)
                                
                                Divider()
                            }
                        }
                    }
                    
                    Divider()
                }
                
                
                // MARK: - Action Buttons
                HStack(spacing: 16) {
                    if let addToCart{
                        Button {
                            addToCart()
                        } label: {
                            Text("Add to Cart")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    .disabled(product?.stock ?? 0 == 0)
                    }
                
                    
                    
                    Button {
                        // Buy Now intentionally empty
                    } label: {
                        Text("Buy Now")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Button("Close"){
                    dismiss()
                }
            }
            .padding()
        }
        .navigationTitle("Product Details")
    }
}
