//
//  Products.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//
import Foundation

struct ProductsList: Codable{
    let products: [Product]
}



struct Product: Codable, Identifiable{
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
    let reviews: [Review]?
    let images: [String]
    let thumbnail: String

    
}




struct Review: Codable, Identifiable {
     
    var id: String  {date}
    let rating: Double
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String
}
