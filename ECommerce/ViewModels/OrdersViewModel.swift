//
//  OrdersViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 16/03/26.
//

import Foundation
internal import Combine

class OrdersViewModel: ObservableObject {

    private let repository = OrdersRepository()
    
    @Published var orders: [OrderModel] = []
    
    init() {
        loadOrders()
    }
    
    func loadOrders() {
        orders = repository.loadOrders()
    }
    
    func checkout(totalItems: Int, totalAmount: Double){
        repository.createOrderFromCart(totalQuantity: totalItems, totalAmount: totalAmount)
        orders = repository.loadOrders()
    }
}
