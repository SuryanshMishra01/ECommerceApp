//
//  SelectableCartItemView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI

struct SelectableCartItemView: View {
    
    let product: CartProduct
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading){
           
            fetchAsyncImage(from: URL(string: product.images.first!)!)
                .frame(width: 100, height: 100,alignment: .leading)
            HStack{
                Text(product.title)
                Text(String(format: "$%.2f",product.price.roundedUp(toPlaces: 2)))
            }
            .padding()
                
            
        }
        .background(isSelected ? Color.accentColor.opacity(0.3) : Color.clear)
        .cornerRadius(10)
        .frame(width: 200, height: 150)
        .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isSelected ? Color.accentColor : Color.gray, lineWidth: isSelected ? 2 : 1)
            )
        
    }
}

#Preview {
    let mock = CartProduct(
           id: 1,
           title: "Test Product",
           price: 99.99,
           images: ["https://cdn.dummyjson.com/product-images/groceries/apple/1.webp"],
           quantity: 2
       )
    SelectableCartItemView(product: mock, isSelected: true)
       
}
