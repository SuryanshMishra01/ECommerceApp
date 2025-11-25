//
//  ItemDetailView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI
internal import CoreData

struct ItemDetailView: View {
    
    @EnvironmentObject var nm: NetworkManager
    @EnvironmentObject var cartVM: CartViewModel
    let id: Int
    var product: Product {
        nm.products[id]
    }
    
    var body: some View {
        VStack {
            HStack{
                fetchAsyncImage(from: URL(string: product.images.first!)!)
                VStack(alignment: .leading){
                    HStack{
                        Text(product.title)
                            .font(Font.largeTitle.bold())
                        Spacer()
                        Text(String(format: "$%.2f",product.price.roundedUp(toPlaces: 2)))
                        
                    }
                    
                    HStack{
                        Text(String(format: "%.1f",product.rating.roundedUp(toPlaces: 1)))
                        Spacer()
                        Text(product.availabilityStatus)
                    }
                    
                    HStack{
                        Text("In Stock: \(product.stock)")
                        Spacer()
                        Button("Add to Cart"){
                            let newItem = CartItem(context: cartVM.context)
                            newItem.id = Int64(product.id)
                            newItem.quantity = Int64(1)
                            cartVM.addToCart(item: newItem)
                        }
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        Button("Buy"){
                            
                        }
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        Spacer()
                    }
                }
            }
            
            Text(product.description)
            Spacer()
            Text("Reviews")
                .font(Font.largeTitle.bold())
            Group{
                if let reviews = product.reviews{
                    List(reviews,id: \.id){review in
                        VStack{
                            HStack{
                                Text(review.reviewerName)
                                Spacer()
                                Text(String(format: "Rating: %.1f",review.rating.roundedUp(toPlaces: 1)))
                                Spacer()
                                Text(review.date)
                                
                            }
                            Text(review.comment)
                        }
                    }
                }else{
                    Text("No Reviews Yet")
                }
                
            }
            .padding()
        }
           
       .padding(20)
    }
}

#Preview {
    ItemDetailView(id: 3)
        .environmentObject(NetworkManager())
    
}
