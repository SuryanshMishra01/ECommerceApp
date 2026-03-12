//
//  ItemsGridView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI

struct CategoryItemsView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    let category: String
    
    var product: [ProductModel] {
        vm.products.filter{$0.category == self.category}
    }
    
     var body: some View {
//         VStack(alignment: .leading) {
//
//             // Product Title
//             Text(product)
//                 .font(.headline)
//                 .lineLimit(2)
//             
//             
//             // Price
//             Text("$\(product.price, specifier: "%.2f")")
//                 .font(.subheadline)
//                 .fontWeight(.semibold)
//                 .foregroundColor(.orange)
//             
//             
//             // Availability
//             Text(product.availabilityStatus)
//                 .font(.caption)
//                 .foregroundColor(product.stock > 0 ? .green : .red)
//             
//             
//             // Add to Cart Button
//            
//         }
//         .padding()
//         .background(.thinMaterial)
//         .clipShape(RoundedRectangle(cornerRadius: 12))
//         .shadow(radius: 2)
     }
    
}

#Preview {
    CategoryItemsView(category: K.Category.beauty )
}
