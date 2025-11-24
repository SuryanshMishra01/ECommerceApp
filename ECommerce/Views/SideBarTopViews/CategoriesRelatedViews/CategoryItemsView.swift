//
//  ItemsGridView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI

struct CategoryItemsView: View {
    @EnvironmentObject var nm: NetworkManager
    let category: String
    
    var dataByCategory: [Product] {
        nm.products.filter{$0.category == self.category}
    }
    
     var body: some View {
       ItemListiew(list: dataByCategory)
         
    }
}

#Preview {
    CategoryItemsView(category: K.Category.beauty )
}
