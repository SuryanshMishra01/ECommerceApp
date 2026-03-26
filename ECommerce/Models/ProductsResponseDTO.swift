//
//  Products.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//
import Foundation

struct ProductsResponseDTO: Codable{
    let products: [ProductDTO]
    let total: Int
}



struct ProductDTO: Codable{
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    var stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int?
    var availabilityStatus: String
    let reviews: [ReviewDTO]?
    let images: [String]
    let thumbnail: String

    
}

// Removed the Identifiable from both DTOs


struct ReviewDTO: Codable{
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}
