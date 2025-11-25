//
//  CartProduct.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//


import Foundation

struct CartProduct: Identifiable, Hashable{
    let id: Int
    let title: String
    let price: Double
    let images: [String]
}
