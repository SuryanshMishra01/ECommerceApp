//
//  ItemsGridView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI

struct CategoryItemsView: View {
    @ObservedObject var nm: NetworkManager
    let category: String
    
    var dataByCategory: [Product] {
        nm.products.filter{$0.category == self.category}
    }
    
    let columns = [
        GridItem(.flexible()),
     
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: self.columns, spacing: 10){
                ForEach(dataByCategory, id: \.id){ product in
                    VStack(alignment: .leading){
                        AsyncImage(url: URL(string: product.images.first!)){phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:150, height: 120)
                                
                                   
                            }else if phase.error != nil{
                                Text("Error Loading Image")
                            }else{
                                ProgressView()
                            }
                        }
                        HStack{
                            Text(product.title)
                            Text(String(format: "%.2f",product.price.roundedUp(toPlaces: 2)))
                        }
                        .padding()
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
            }
        }
    }
}

#Preview {
    CategoryItemsView(nm: NetworkManager(), category: K.Category.beauty )
}
