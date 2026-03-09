//
//  ProductsRepository.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 09/03/26.
//

import Foundation
internal import CoreData

class ProductsRepository {
    
    let apiService = ProductAPIService()
    let context = PersistenceController.shared.context
    
    func syncProducts() async throws{
        do{
            let products = try await apiService.fetchData()
            saveProducts(products)
        }catch{
            throw error
        }
    }
    
    private func saveProducts(_ dtos: [ProductDTO]) {
        for dto in dtos{
            _ = ProductEntity.fromDTO(dto, context: context)
            
        }
    }
    
}


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
               
        return product
    }
}
