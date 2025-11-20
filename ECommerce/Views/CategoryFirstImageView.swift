//
//  CategoryFirstImageView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI

struct CategoryFirstImageView: View {
    @ObservedObject var nm: NetworkManager
    let category: String
    
    var body: some View {
        
        if let urlString = nm.products.first(where: {$0.category == category})?.images.last,
           let url = URL(string: urlString){
            
            AsyncImage(url: url){phase in
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
        }else{
            Text("No Image of \(category.capitalized) Product")
        }
    }
        
}

#Preview {
    CategoryFirstImageView(nm: NetworkManager(), category: K.Category.beauty)
}
