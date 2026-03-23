//
//  CartsView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var ordersVM: OrdersViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @State private var orderPlaced = false
    
    var body: some View {
//        if cartVM.cartItems.isEmpty {
//            EmptyCartView()
//        }else{
            VStack(spacing: 0) {
                
                List(cartVM.cartItems, id: \.id) { item in
                    cartRow(item: item)
                }
                
                cartSummary
            }
//        }
        .onAppear {
            cartVM.loadCart()
        }
    }
    
    //MARK: - Empty Cart View
    
    var EmptyCartView: some View {
        VStack{
            
            Text("Your cart is empty")
                .font(.largeTitle)
                .foregroundColor(AppColors.textSecondary)
                .padding()
        }
    }
    
    //MARK: - Cart Row
    
    func cartRow(item: CartItemModel) -> some View {
                HStack {
                    if let url = item.product.images.first {
                        ProductImageView(url: url, height: 70)
                            .frame(maxWidth: 140)
                        
                    } else {
                        ProgressView()
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text(item.product.title)
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text("$\(item.product.price, specifier: "%.2f")")
                            .font(.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        
                        Button {
                            cartVM.removeProduct(item.product)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(AppColors.primary)

                        }
                        
                        Text("\(item.quantity)")
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Button {
                            cartVM.addProduct(item.product)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(AppColors.primary)
                        }
                    }
                    .font(.title3)
                }
            
        }
    
    
    //MARK: - Cart Summary
    
    var cartSummary: some View {
        VStack(spacing: 12) {

            HStack {
                Text("Items")
                Spacer()
                Text("\(cartVM.totalItems)")
            }

            HStack {
                Text("Total")
                    .fontWeight(.bold)
                Spacer()
                Text("$\(cartVM.totalPrice)")
                    .fontWeight(.bold)
            }

            Button {

                ordersVM.checkout(totalItems: cartVM.totalItems, totalAmount: cartVM.totalPrice)

                orderPlaced = true

                Task {
                    try? await Task.sleep(for: .seconds(1.5))
                    cartVM.loadCart()
                    orderPlaced = false
                }

            } label: {
                Text("Checkout")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.accent)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            }

        }
        .padding()
        .background(AppColors.background)
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

