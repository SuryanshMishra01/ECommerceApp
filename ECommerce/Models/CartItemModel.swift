//
//  CartItemModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 13/03/26.
//

import Foundation

struct CartItemModel: Identifiable{
    var id: Int {product.id}
    let product: ProductModel
    let quantity: Int
}
