//
//  ProductsRepository.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 09/03/26.
//

import Foundation
internal import CoreData

// Note - Some things are commented in this code for testing purpose only
class ProductsRepository {
    
    let apiService = ProductAPIService()
    let context = PersistenceController.shared.context
    
    func syncProducts(skip: Int, limit: Int) async throws -> Int {
        
        let response = try await apiService.fetchData(skip: skip, limit: limit)
        
        saveProducts(response.products)
        
        return response.total
    }
    
    // just a helper created & used for testing
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
        save()
    }
    
    func fetchProducts() throws -> [ProductModel]{
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.sortDescriptors = [ NSSortDescriptor(key: "productID", ascending: true) ]
        let entities = try context.fetch(request)
        return entities.map { ProductModel(entity: $0)}
    }
    
    // MARK: Save Context

    private func save() {

        if context.hasChanges {
            try? context.save()
        }
    }
}



