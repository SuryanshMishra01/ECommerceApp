//
//  CategoryFirstImageView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI


struct CategoryFirstImageView: View {
    @EnvironmentObject var nm: NetworkManager
    let category: String
    
 
    var body: some  View {
        
        if let urlString = nm.products.first(where: {$0.category == category})?.images.last{
          let _ = print(urlString)
            fetchAsyncImage(from: URL(string: urlString)!)
        }else{
            Text("No Image of \(category.capitalized) Product")
        }
        
    }
        
}

#Preview {
    CategoryFirstImageView(category: K.Category.beauty)
       
}
