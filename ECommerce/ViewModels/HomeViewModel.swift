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
//    private var prefetcher: ImagePrefetcher?       // image prefetcher for caching
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // To make it searchable
    @Published var products: [ProductModel] = []
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
        defer{ isLoading = false }
        do {
            isLoading = true
            try await repository.syncProducts()
            
            products = try repository.fetchProducts()
            
        } catch {
            errorMessage = error.localizedDescription
        }
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

