//
//  NetworkManager.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import Foundation
internal import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var products: [Product] = []
  
   
    
    func fetchData() async throws  {
        guard let url = URL(string: K.api) else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ProductsList.self, from: data)
            DispatchQueue.main.async {
                self.products = decodedData.products
            }
        } catch {
            print("Error in fetching data: \(error)")
        }
    }
    
    
}
