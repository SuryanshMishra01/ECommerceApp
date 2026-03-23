//
//  AppButtons.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 23/03/26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(AppColors.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12) // control height properly
                .background(AppColors.primary)
                .cornerRadius(10)
                
        }
    }
}



struct SecondaryButton: View{
    let title: String
    let action : () -> Void
    var body: some View {
        Button(action: action){
            Text(title)
                .foregroundColor(AppColors.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12) // control height properly
                .background(AppColors.secondary)
                .cornerRadius(10)
        }
        
    }
}


struct CartButton : View{
    
    let product: ProductModel
    
    @EnvironmentObject var cartVM: CartViewModel
    
    var quantity: Int {
        cartVM.checkQuantity(for: product)
    }
    
    var body: some View {
        
        if quantity == 0 {
            
            Button {
                cartVM.addProduct(product)
            } label: {
                Text("Add to Cart")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(10)
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
            .padding(.vertical, 6)
        }
    }
}
