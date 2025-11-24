//
//  HomeView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//



import SwiftUI

struct HomeView: View {
    @EnvironmentObject var nm: NetworkManager
//    @State private var searchedText: String = ""
   
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: self.columns, spacing: 10){
                ForEach(nm.products, id: \.id){ product in
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
                                NavigationLink("Add to Cart"){
                                    
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
    HomeView()
}
