//
//  ProductImageView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 10/03/26.
//

import SwiftUI

struct ProductImageView: View {
    
    let url: String
    var height: CGFloat = 120
    
    var body: some View {
        
        AsyncImage(url: URL(string: url)) { phase in
            
            switch phase {
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                
            case .failure(_):
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                
            default:
                ProgressView()
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(Color(.gray))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
