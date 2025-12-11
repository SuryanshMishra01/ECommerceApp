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
    var nm: NetworkManager
    
    @Published var cart: [CartItem] = []
    
    init(context: NSManagedObjectContext, nm: NetworkManager){
        self.context = context
        self.nm = nm
    }
    
    
    func loadCart(){
        let result = CartItem.fetchRequest()
            
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
    
    func removeFromCart(id: Int){
        
        let request = CartItem.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            if let cartItem = try self.context.fetch(request).first{
                if cartItem.quantity == 1{
                    self.context.delete(cartItem)
                   
                }else{
                    cartItem.quantity = cartItem.quantity - 1
                }
                try self.context.save()
                loadCart()
                nm.addToMainList(id: id)
            }
            
        }catch{
            print("Error deleting cart item ...")
        }
    }
        
    func addToCart(item: CartItem){
        
        let request = CartItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", item.id)
        do{
        if let cartItem = try self.context.fetch(request).first{
            cartItem.quantity = cartItem.quantity   + 1                     // (1 = item.quantity)
        }else{
            let newItem = CartItem(context: self.context)
            newItem.id = Int64(item.id)
            newItem.quantity = Int64(item.quantity)
        }
     
               try PersistenceController.shared.save(context: self.context)
                print("Added Item to Cart")
                
        }catch{
                print("Error adding item to Cart")
            }
        }
        
        
}

