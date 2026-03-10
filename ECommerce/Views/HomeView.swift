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

        NavigationStack {

            ScrollView {

                LazyVGrid(columns: columns, spacing: 16) {

                    ForEach(homeVM.filteredProducts) { product in
                        NavigationLink{
                            ItemDetailView(product: product){
                                cartVM.addProduct(product)
                            }
                        }label:{
                            ProductCard(product: product){
                                cartVM.addProduct(product)
                            }
                        }
                    }

                    if homeVM.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Products")
        }
        .task {
            await homeVM.loadProducts()
        }
    }
}
struct ProductCard: View {

    let product: ProductModel
    var addToCart: (() -> Void)? = nil
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ProductImageView(url: product.images.first ?? "")
            
            // Product Title
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
            
            
            // Price
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.orange)
            
            
            // Availability
            Text(product.availabilityStatus)
                .font(.caption)
                .foregroundColor(product.stock > 0 ? .green : .red)
            
            
            // Add to Cart Button
            if let addToCart {
                Button {
                    addToCart()
                } label: {
                    Text("Add to Cart")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    HomeView()
        
}
