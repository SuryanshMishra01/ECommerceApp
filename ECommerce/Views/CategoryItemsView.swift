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
                        fetchAsyncImage(from: URL(string: product.images.first!)!)
                        HStack{
                            Text(product.title)
                            Text(String(format: "%.2f",product.price.roundedUp(toPlaces: 2)))
                        }
                        .padding()
                        NavigationStack{
                            HStack{
                            
                                Spacer()
                                NavigationLink("Add to Cart"){
                                    
                                }
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                NavigationLink("Check Details"){
                                    ItemDetailView(nm: self.nm, id: product.id)
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
}

#Preview {
    CategoryItemsView(nm: NetworkManager(), category: K.Category.beauty )
}
