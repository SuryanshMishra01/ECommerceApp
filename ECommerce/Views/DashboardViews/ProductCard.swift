//
//  ProductCard.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 13/03/26.
//
import SwiftUI

struct ProductCard: View {

    let product: ProductModel
    @EnvironmentObject var cartVM: CartViewModel
    
    
    var quantity: Int {
           cartVM.checkQuantity(for: product)
    }

    
    var body: some View {
        
        VStack(alignment: .leading) {
            ProductImageView(url: product.images.first ?? "")
            Text(product.images.first ?? "")
                 // Product Title)
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
               cartButton
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
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
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

        } else {

            HStack {

                Button {
                    cartVM.removeProduct(product)
                } label: {
                    Image(systemName: "minus.circle.fill")
                }

                Spacer()

                Text("\(quantity)")
                    .fontWeight(.bold)

                Spacer()

                Button {
                    cartVM.addProduct(product)
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .font(.title3)
            .padding(.vertical, 4)
        }
    }
}
