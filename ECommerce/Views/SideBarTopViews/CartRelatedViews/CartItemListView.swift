//
//  CartItemListView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI
internal import CoreData

struct CartItemListiew: View {
    @EnvironmentObject var nm: NetworkManager
    @EnvironmentObject var cartVM : CartViewModel
    var productList: [Product] {
        nm.products.filter { product in
            cartVM.cart.contains(where: { $0.id == product.id })
        }
    }
    @State private var cartProductList : [CartProduct] = []
    @State private var selectedItems : Set<CartProduct> = []

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            VStack{
                LazyVGrid(columns: self.columns, spacing: 10){
                    ForEach(cartProductList, id: \.id){ cartProduct in
                        VStack{
                            SelectableCartItemView(product: cartProduct, isSelected: selectedItems.contains(cartProduct))
                                .onTapGesture{
                                    toggleSelection(cartProduct)
                                }
                            Button("Remove"){
                                cartVM.removeFromCart(id: cartProduct.id)
                                cartVM.loadCart()
                            }
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                        
                    }
                    
                }
            }
            .padding()
            Spacer()
            HStack{
               Spacer()
                Button("Buy"){
                    
                }
               
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                Spacer()
            }
        }
        .onAppear {
            cartProductList = productList.map { product in
                CartProduct(
                    id: product.id,
                    title: product.title,
                    price: product.price,
                    images: product.images
                )
            }
        }

        
    }
    func toggleSelection(_ product: CartProduct){
        if selectedItems.contains(product){
            selectedItems.remove(product)
        }else{
            selectedItems.insert(product)
        }
    }
}

#Preview {
    let nm = NetworkManager()
    let cartVM = CartViewModel(context: PersistenceController.shared.container.viewContext)
    

    CartItemListiew()
        .environmentObject(cartVM)
        .environmentObject(nm)
        .onAppear {
            cartVM.loadCart()
        }
    
}
