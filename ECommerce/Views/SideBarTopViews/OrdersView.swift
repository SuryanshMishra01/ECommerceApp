//
//  OrdersView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct OrdersView: View {
    @State private var selectedOrder: OrderModel?
    @State private var showDetail = false
    @EnvironmentObject private var ordersVM : OrdersViewModel
    
    var body: some View {
        
        NavigationStack {
            
            List(ordersVM.orders, selection: $selectedOrder) { order in
                
                orderRow(order)
                    .onTapGesture(count: 2) {
                        selectedOrder = order
                        showDetail = true
                    }
            }
            .navigationTitle("Orders")
            //  Double click opens sheet
            
            
            // Trigger sheet when selection changes
            .onChange(of: selectedOrder) { _, order in
                if order != nil {
                    showDetail = true
                }
            }
            
            // Sheet
            .sheet(isPresented: $showDetail) {
                if let order = selectedOrder {
                    OrderDetailView(order: order)
                        .frame(minWidth: 500, minHeight: 400)
                }
            }
        }
    }
    
    func orderRow(_ order: OrderModel) -> some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            Text("Order ID: \(order.id.uuidString.prefix(6))")
                .font(.headline)
                .foregroundColor(AppColors.textPrimary)
            
            HStack {
                
                Text("Items: \(order.quantity)")
                
                Spacer()
                
                Text("$\(order.totalPrice, specifier: "%.2f")")
                    .fontWeight(.semibold)
                    
            }
            .foregroundColor(AppColors.accent)
            
            Text(order.timestamp.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(AppColors.textSecondary)
        }
    }
}

#Preview {
    OrdersView()
}
