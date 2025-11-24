//
//  CartItemListView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI

struct CartItemListiew: View {
    @EnvironmentObject var nm: NetworkManager
    @EnvironmentObject var vm : CartViewModel
    var productList: [Product] {
        nm.products.filter { product in
            vm.cart.contains(where: { $0.id == product.id })
        }
    }

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: self.columns, spacing: 10){
                ForEach(productList, id: \.id){ product in
                    VStack(alignment: .leading){
                        fetchAsyncImage(from: URL(string: product.images.first!)!)
                        HStack{
                            Text(product.title)
                            Text(String(format: "$%.2f",product.price.roundedUp(toPlaces: 2)))
                        }
                        .padding()
                        NavigationStack{
                            HStack{
                            
                                Spacer()
                                Button("Remove"){
                                    vm.removeFromCart(id: product.id)
                                    vm.loadCart()
                                }
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                NavigationLink("Buy"){
                                    ItemDetailView(id: product.id)
                                }
                                .background(Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                Spacer()
                            }
                        }
                    }
                 
                }
//                .searchable(text: $searchedText)
            }
        }
    }
}

#Preview {
    let nm = NetworkManager()
    let cartVM = CartViewModel(context: PersistenceController.shared.container.viewContext)

    CartItemListiew()
        .environmentObject(cartVM)
        .environmentObject(nm)
    
}
