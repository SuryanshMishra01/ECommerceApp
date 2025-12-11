//
//  ItemListView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//

import SwiftUI
internal import CoreData

struct ItemListiew: View {
    @EnvironmentObject var nm: NetworkManager
    @EnvironmentObject var vm : CartViewModel
    private var productList: [Product] = []
    
    init(list: [Product]){
        productList = list
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
                                Button("Add to Cart"){
                                    let newItem = CartItem(context: vm.context)
                                    newItem.id = Int64(product.id)
                                    newItem.quantity = Int64(1)
                                    vm.addToCart(item: newItem)
                                    
                                }
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                NavigationLink("Check Details"){
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
    let cartVM = CartViewModel(context: PersistenceController.shared.container.viewContext, nm: nm)

    ItemListiew(list: nm.products)
        .environmentObject(cartVM)
        .environmentObject(nm)
    
}
