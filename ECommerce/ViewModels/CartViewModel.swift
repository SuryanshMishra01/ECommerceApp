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

    @Published var cartItems: [CartItemEntity] = []

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
}
