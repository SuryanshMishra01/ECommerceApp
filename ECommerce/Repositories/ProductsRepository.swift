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
        
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

       let count = try context.count(for: request)

       // If products already exist, skip API call
       if count > 0 {
           return
       }
        do{
            let products = try await apiService.fetchData()
            deleteAllProducts()
            saveProducts(products)
        }catch{
            throw error
        }
    }
    
    private func deleteAllProducts() {

        let request: NSFetchRequest<NSFetchRequestResult> = ProductEntity.fetchRequest()

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete products:", error)
        }
    }
    
    private func saveProducts(_ dtos: [ProductDTO]) {
        for dto in dtos{
            let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
            request.predicate = NSPredicate(format: "productID == %d", dto.id)
            let existing = try? context.fetch(request).first
            if existing == nil{
                _ = ProductEntity.fromDTO(dto, context: context)
            }
        
            
        }
        try? PersistenceController.shared.save(context: context)
    }
    
    func fetchProducts() throws -> [ProductModel]{
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities.map { ProductModel(entity: $0)}
    }
}



