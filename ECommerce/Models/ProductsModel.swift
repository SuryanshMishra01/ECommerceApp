//
//  ProductsModel.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 10/03/26.
//

import Foundation

struct ProductModel: Identifiable{
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let rating: Double
    var stock: Int
    let brand: String?
    let sku: String
    let reviews: [ReviewDTO]?
    let images: [String]
    var availabilityStatus: String{
        stock > 0 ? "In Stock" : "Out of Stock"
    }
}

extension ProductModel{
    init(entity: ProductEntity){
        self.id = Int(entity.productID)
        self.title = entity.title ?? ""
        self.description = entity.productDescription ?? ""
        self.price = entity.price
        self.stock = Int(entity.stock)
        self.rating = Double(entity.rating)
        self.category = entity.category ?? ""
        self.brand = entity.brand
        self.sku = entity.sku ?? ""
        let imageEntity = entity.images as? Set<ProductImageEntity> ?? []
        self.images = imageEntity.map{ $0.url ?? ""}
        let reviewEntity = entity.reviews as? Set<ReviewEntity> ?? []
        self.reviews = reviewEntity.map{
            ReviewDTO(
                rating: Int($0.rating),
                comment: $0.comment ?? "",
                date: $0.date ?? "",
                reviewerName: $0.reviewerName ?? "",
                reviewerEmail: $0.reviewerEmail ?? "",
            )
        }
    }
}
