//
//  ProductEntity+Extension.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 10/03/26.
//

internal import CoreData

extension ProductEntity{
    static func fromDTO(_ dto: ProductDTO, context: NSManagedObjectContext) -> ProductEntity{
        let product = ProductEntity(context: context)
        product.productID = Int64(dto.id)
        product.title = dto.title
        product.price = Double(dto.price)
        product.stock = Int64(dto.stock)
        product.sku = dto.sku
        product.productDescription = dto.description
        product.rating = Int64(dto.rating)
        product.category = dto.category
      //  product.reviews & images 
               
        return product
    }
}
