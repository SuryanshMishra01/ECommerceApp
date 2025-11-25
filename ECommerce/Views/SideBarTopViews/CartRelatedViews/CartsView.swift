//
//  CartsView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI
internal import CoreData

struct CartsView: View {
    
    @EnvironmentObject var cartVM: CartViewModel
    var body: some View {
        Text("Cart")
            .font(.title.bold())
            .padding()
        Group{
            if cartVM.cart.isEmpty{
                Text("You Cart is Empty")
            } else{
                CartItemListiew()
            }
        }
        
            .onAppear(){
                cartVM.loadCart()
            }
    }
        
               
      
        
}

#Preview {
    CartsView()
        .environmentObject(CartViewModel(context: PersistenceController.shared.container.viewContext))
   
}
