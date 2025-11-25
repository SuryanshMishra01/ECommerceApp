//
//  CartViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//


import SwiftUI
internal import CoreData
internal import Combine

class CartViewModel: ObservableObject {
    
    
    let context: NSManagedObjectContext
    
    @Published var cart: [CartItem] = []
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    
    func loadCart(){
        let result = CartItem.fetchRequest()
        context.perform {
            
            do{
                if let cart = try self.context.fetch(result) as [CartItem]?{
                    print(cart)
                    DispatchQueue.main.async {
                        self.cart = cart
                    }
                }
            }catch{
                print("Error in loading cart ...")
            }
        }
    }
    
    func removeFromCart(id: Int){
        
        let request = CartItem.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            if let cartItem = try self.context.fetch(request).first{
                self.context.delete(cartItem)
                try self.context.save()
                loadCart()
            }
            
        }catch{
            print("Error deleting cart item ...")
        }
    }
        
    func addToCart(item: CartItem){
            let newItem = CartItem(context: self.context)
            newItem.id = Int64(item.id)
            newItem.quantity = Int64(item.quantity)
            do{
               try PersistenceController.shared.save(context: self.context)
                print("Added Item to Cart")
                
            }catch{
                print("Error adding item to Cart")
            }
        }
        
        
}

