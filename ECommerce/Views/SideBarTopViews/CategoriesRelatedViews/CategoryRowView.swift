//
//  CategoryRowView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 11/12/25.
//



import SwiftUI

struct CategoryRowView: View {
    
    let title: String
    let category: String
    
    
    var body: some View {
        HStack{
            CategoryFirstImageView(category: category)
                .frame(width:60, height: 60)
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.secondary)
        }
        .padding()
    }
}

