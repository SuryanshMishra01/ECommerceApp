//
//  CartViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//


import SwiftUI
import CoreData
internal import Combine

class CartViewModel: ObservableObject {
    
   private let  nm: NetworkManager
    
    private let context: NSManagedObjectContext
    
    
    
    @Published var cart: [CartItem] = []
    
    init(context: NSManagedObjectContext, nm: NetworkManager){
        self.context = context
        self.nm = nm
        
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
        
        func addToCart(id: Int){
            let item = CartItem(context: self.context)
            item.id = Int64(id)
            item.quantity = Int64(nm.products.first(where: { $0.id == id })?.stock ?? 0)
            
        }
        
        
    }
    
}
