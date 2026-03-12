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
    
    
    func loadCart() -> [CartItemEntity]{
        
        guard let userID = SessionManager.shared.userID else { return [] }

        let request: NSFetchRequest<CartItemEntity> = CartItemEntity.fetchRequest()

        request.predicate = NSPredicate(format: "user.userid == %@", userID)

        do {
            return try context.fetch(request)
        } catch {
            print("Cart fetch error:", error)
            return []
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

     // MARK: Save Context

     private func save() {

         if context.hasChanges {
             try? context.save()
         }
     }
}
