//
//  OrdersView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct OrdersView: View {
    
    @EnvironmentObject private var ordersVM : OrdersViewModel
    
    var body: some View {
        
        NavigationStack {
            
            List(ordersVM.orders) { order in
                
                orderRow(order)
                
            }
            .navigationTitle("Orders")
        }
    }
    
    func orderRow(_ order: OrderModel) -> some View {

        VStack(alignment: .leading, spacing: 6) {

            Text("Order ID: \(order.id.uuidString.prefix(6))")
                .font(.headline)

            HStack {

                Text("Items: \(order.quantity)")

                Spacer()

                Text("$\(order.totalPrice, specifier: "%.2f")")
                    .fontWeight(.semibold)
            }

            Text(order.timestamp.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    OrdersView()
}
