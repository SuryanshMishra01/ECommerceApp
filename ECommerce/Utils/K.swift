//
//  K.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

struct K{
    static let api = "https://dummyjson.com/products"
    
    struct Category  {
        static let grocery = "groceries"
        static let furniture = "furniture"
        static let beauty = "beauty"
        static let fragrance = "fragrances"
    }
    
    static let dummyProduct: ProductModel = ProductModel(id: 0, title: "", description: "", category: "", price: 0.0, rating: 0.0, stock: 0, brand: "", sku: "", reviews: [], images: [])
}


