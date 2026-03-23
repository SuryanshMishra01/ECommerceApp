//
//  ContentView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData

struct CategoriesView: View {
  
    @EnvironmentObject var homeVM: HomeViewModel
    

    var body: some View {
        List {
            NavigationLink{
                
            }label: {
                <#code#>
            }
            NavigationLink{
                
            }label: {
                <#code#>
            }
            NavigationLink{
                
            }label: {
                <#code#>
            }
            NavigationLink{
                
            }label: {
                <#code#>
            }
        }
        .navigationTitle("Categories")
    }
    
    func CategoryFirstImage(category: String) -> some View {
        if let urlString = homeVM.products.first(where: {$0.category == category})?.images.last{
            ProductImageView(url: urlString, height: 250)
        }else{
            Text("No Image of \(category.capitalized) Product")
        }
    }
   
    
}

#Preview {
    CategoriesView()
}
