//
//  NetworkManager.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import Foundation
internal import Combine
import SwiftUI
import os

class ProductAPIService: ObservableObject {
    let logger = Logger(subsystem: "com.wg.ECommerce", category: "ProductAPIService")
    
    
    func fetchData() async throws  -> [ProductDTO]{
    
        guard let url = URL(string: K.api) else {
            throw URLError(.badURL)
        }
   
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse {
            logger.info("HTTP Status Code: \(httpResponse.statusCode)")
        }
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(ProductsResponseDTO.self, from: data)
        return decodedData.products
    }
    
    

}
