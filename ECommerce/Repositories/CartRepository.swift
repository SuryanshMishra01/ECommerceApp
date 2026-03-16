//
//  CartRepository.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 10/03/26.
//

import Foundation
internal import CoreData

class CartRepository {
    private let context = PersistenceController.shared.context
    
    
    func loadCart() -> [CartItemModel] {

        guard let userID = SessionManager.shared.userID else { return [] }

        let request: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()

        request.predicate = NSPredicate(format: "user.userid == %@", userID)

        let items = (try? context.fetch(request)) ?? []

        return items.compactMap { entity in

            guard let product = entity.product else { return nil }

            return CartItemModel(
                product: ProductModel(entity: product),
                quantity: Int(entity.quantity)
            )
        }
    }
    
    // MARK: Add Product To Cart

     func saveToCart(product: ProductModel) {

         guard let userID = SessionManager.shared.userID else { return }

         // fetch product entity
         let productRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
         productRequest.predicate = NSPredicate(format: "productID == %d", product.id)

         guard let productEntity = try? context.fetch(productRequest).first else { return }

         if productEntity.stock <= 0 {
             print("Out of stock")
             return
         }

         // fetch user
         let userRequest: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
         userRequest.predicate = NSPredicate(format: "userid == %@", userID)

         guard let userEntity = try? context.fetch(userRequest).first else { return }

         // check if product already in cart
         let cartRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()

         cartRequest.predicate = NSPredicate(
             format: "product.productID == %d AND user.userid == %@",
             product.id,
             userID
         )

         if let existing = try? context.fetch(cartRequest).first {

             existing.quantity += 1

         } else {

             let cartItem = CartItemEntity(context: context)

         
             cartItem.quantity = 1
             
             // Core Data internally updates the inverse, if configured properly
             cartItem.product = productEntity
             cartItem.user = userEntity
         }

         // update stock
         productEntity.stock -= 1

         save()
     }
    
    //MARK: - Remove Cart Item
    
    func removeFromCart(product: ProductModel){
        guard let userID = SessionManager.shared.userID else { return }
        
        let request : NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "product.productID == %d AND user.userid == %@", product.id, userID)
        guard let cartItem = try? context.fetch(request).first else { return }
        
        guard let productEntity = cartItem.product else { return }
        
        if cartItem.quantity > 1{
            cartItem.quantity -= 1
        }else{
            context.delete(cartItem)
            
        }
        productEntity.stock += 1
        
        save()
    }
  
    //MARK: - checkout logic
    
    func checkout(totalItems: Int, totalPrice: Double) {

        guard let userID = SessionManager.shared.userID else { return }

        // Fetch user
        let userRequest: NSFetchRequest<UserProfileEntity> = UserProfileEntity.fetchRequest()
        userRequest.predicate = NSPredicate(format: "userid == %@", userID)

        guard let user = try? context.fetch(userRequest).first else { return }

        // Fetch cart items
        let cartRequest: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()
        cartRequest.predicate = NSPredicate(format: "user.userid == %@", userID)

        guard let cartItems = try? context.fetch(cartRequest), !cartItems.isEmpty else { return }

        // Create order
        let order = OrderEntity(context: context)

        order.orderID = UUID()
        order.timestamp = Date()
        order.totalPrice = totalPrice
        order.quantity = Int64(totalItems)
        order.user = user

        // Add products to order
        for item in cartItems {
            if let product = item.product {
                order.addToProducts(product)
            }
        }

        // Clear cart
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
