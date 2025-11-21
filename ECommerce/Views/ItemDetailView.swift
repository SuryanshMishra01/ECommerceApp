//
//  ItemDetailView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct ItemDetailView: View {
    
    @ObservedObject var nm: NetworkManager
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
                           Text("$\(product.price.roundedUp(toPlaces: 2))")
                           
                       }
                
                       HStack{
                           Text("\(product.rating)")
                           Spacer()
                           Text(product.availabilityStatus)
                       }
                
                       HStack{
                           Spacer()
                           Button("Add to Cart"){
                               
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
           
           
           
           
        }
    }
}

#Preview {
    ItemDetailView(nm: NetworkManager(), id: 3)
}
