//
//  CartsView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI
struct CartView: View {

    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack{
            List(cartVM.cartItems, id: \.id) { item in
            
                HStack(alignment: .center){
                    if let url = item.product.images.first{
                        ProductImageView(url: url, height: 70)
                    }else{
                        ProgressView()
                    }
                    
                    Text(item.product.title)
                    
                    Spacer()
                    
                    Text("Qty: \(item.quantity)")
                }
            }
           Spacer()
            Button{
                // Order View will be updated
            }label: {
                Text("Checkout")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(20)
                
        }
        .onAppear {
            cartVM.loadCart()
        }
    }
}
