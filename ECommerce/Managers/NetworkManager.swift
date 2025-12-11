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
    
    private var isFetched = false
   
    
    func fetchData() async throws  {
        if isFetched {
            return
        }
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
                self.isFetched = true
            }
        } catch {
            print("Error in fetching data: \(error)")
        }
    }
    
    
    func removeFromMainList(id: Int){
        if let index =  products.firstIndex(where: { $0.id == id }) {
            products[index].stock -= 1
            
            
            if products[index].stock ==  0{
                products[index].availabilityStatus = "Out of Stock"
            }
                
            
        }
    }
    
    
    func addToMainList(id: Int){
        if let index =  products.firstIndex(where: { $0.id == id }) {
                        
            if products[index].stock ==  0{
                products[index].availabilityStatus = "In Stock"
            }
            products[index].stock += 1
            
            
        }
    }
    
}
