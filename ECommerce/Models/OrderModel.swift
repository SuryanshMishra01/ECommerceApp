//
//  Untitled.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 16/03/26.
//

import Foundation

struct OrderModel: Identifiable, Hashable{
    
    let id: UUID
    let timestamp: Date
    let totalPrice: Double
    let quantity: Int
    let products: [ProductModel]
}

extension OrderModel {

    init(entity: OrderEntity) {
        
        self.id = entity.orderID ?? UUID()
        self.timestamp = entity.timestamp ?? Date()
        self.totalPrice = entity.totalPrice
        self.quantity = Int(entity.quantity)
        
        self.products = (entity.products as? Set<ProductEntity> ?? [])
            .map { ProductModel(entity: $0) }
    }
}
