//
//  OrdersRepository.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 16/03/26.
//


import Foundation
internal import CoreData

class OrdersRepository{
    
    private let context = PersistenceController.shared.context
    
    // MARK: Fetch Orders
      
      func loadOrders() -> [OrderModel] {
          
          guard let userID = SessionManager.shared.userID else { return [] }
          
          let request: NSFetchRequest<OrderEntity> = OrderEntity.fetchRequest()
          
          request.predicate = NSPredicate(format: "user.userid == %@", userID)
          
          request.sortDescriptors = [
              NSSortDescriptor(keyPath: \OrderEntity.timestamp, ascending: false)
          ]
          
          let orders = (try? context.fetch(request)) ?? []
          
          return orders.map { OrderModel(entity: $0) }
      }
    func createOrderFromCart(totalQuantity: Int, totalAmount: Double) {
        
        guard let userID = SessionManager.shared.userID else { return }
        
        // Fetch user
        let userRequest: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        userRequest.predicate = NSPredicate(format: "userid == %@", userID)
        
        guard let user = try? context.fetch(userRequest).first else { return }
        
        // Fetch cart items
        let cartRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
        cartRequest.predicate = NSPredicate(format: "user.userid == %@", userID)
        
        guard let cartItems = try? context.fetch(cartRequest), !cartItems.isEmpty else { return }
        
        let order = OrderEntity(context: context)
        
        order.orderID = UUID()
        order.timestamp = Date()
        order.user = user
      
        
        for item in cartItems {
            
            guard let product = item.product else { continue }
            
            order.addToProducts(product)
            // optinally we can check total price and quantity in the loop for verification of order
        }
        
        order.totalPrice = totalAmount
        order.quantity = Int64(totalQuantity)
        
        // clear cart
        for item in cartItems {
            context.delete(item)
        }
        
        save()
    }
    
    // MARK: Save Context

    private func save() {

        if context.hasChanges {
            try? context.save()
        }
    }
}
