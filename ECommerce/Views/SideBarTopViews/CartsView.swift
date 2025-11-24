//
//  CartsView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct CartsView: View {
    
    @EnvironmentObject var nm: NetworkManager
    @StateObject private var vm: CartViewModel
    
   
    
    var cartItems: [Product]{
        nm.products.filter{product in
            vm.cart.contains(where: {$0.id == product.id})
        }
    }
    
    init(){
        _vm = StateObject(wrappedValue: CartViewModel(context: PersistenceController.shared.container.viewContext))
    }
        
        
        var body: some View {
            CartItemListiew()
                .environmentObject(vm)
                .environmentObject(nm)
                .onAppear(){
                    vm.loadCart()
                }
        }
        
}

#Preview {
    CartsView()
        .environmentObject(CartViewModel(context: PersistenceController.shared.container.viewContext))
        .environmentObject(NetworkManager())
}
