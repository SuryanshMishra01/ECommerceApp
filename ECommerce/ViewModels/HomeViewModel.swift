//
//  Untitled.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 10/03/26.
//

import Foundation
internal import Combine
//import Nuke

@MainActor
class HomeViewModel: ObservableObject {
    
    private let repository = ProductsRepository()
    private var skip = 0
    private let limit = 30
    private var total = Int.max
    @Published var products: [ProductModel] = []

//    private var prefetcher: ImagePrefetcher?       // image prefetcher for caching
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // To make it searchable
    @Published var searchText: String = ""
    var filteredProducts	: [ProductModel] {
        if searchText.isEmpty {
            return products
        }
        return products.filter{
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func loadProducts() async {
        guard products.isEmpty else { return }
        
        await loadMoreProducts()
    }
    
    func loadMoreProducts() async {
        
        guard !isLoading else { return }
        guard products.count < total else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let totalToFetch = try await repository.syncProducts(skip: skip, limit: limit)
            
            skip += limit
            
            total = totalToFetch
            
            products = try repository.fetchProducts()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    
    func loadMoreProductsIfNeeded(currentItem: ProductModel) async {
        
        if currentItem.id == products.last?.id {
            await loadMoreProducts()
        }

    }
    
    // helper for testing
    func deleteAllProducts(){
        repository.deleteAllProducts()
        
    }
}
    
    //MARK: - Image Caching helper
    
//    func prefetchImages() {
//
//        let requests = products.prefix(20).compactMap {
//            URL(string: $0.images.first ?? "")
//        }.map {
//            ImageRequest(url: $0)
//        }
//
//        prefetcher = ImagePrefetcher(requests: requests)
//        prefetcher?.start()
//    }

