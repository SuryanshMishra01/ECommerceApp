//
//  CartViewModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 24/11/25.
//


import SwiftUI
internal import Combine

class CartViewModel: ObservableObject {

    private let repository = CartRepository()

    @Published var cartItems: [CartItemModel] = []

    init() {
        loadCart()
    }

    // MARK: Load Cart

    func loadCart() {

        cartItems = repository.loadCart()
    }

    // MARK: Add To Cart

    func addProduct(_ product: ProductModel){
        repository.saveToCart(product: product)
        loadCart()
    }
    
    func removeProduct(_ product: ProductModel){
        repository.removeFromCart(product: product)
        loadCart()
    }
    
    
    //MARK: - Function to check quantity
    
    func checkQuantity(for product: ProductModel) -> Int{
        cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }
    
    
}
