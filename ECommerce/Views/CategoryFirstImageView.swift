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
    
 
    var body: some  View {
        
        if let urlString = nm.products.first(where: {$0.category == category})?.images.last,
           let url = URL(string: urlString){
            fetchAsyncImage(from: url)
        }else{
            Text("No Image of \(category.capitalized) Product")
        }
    }
        
}

#Preview {
    CategoryFirstImageView(nm: NetworkManager(), category: K.Category.beauty)
}
