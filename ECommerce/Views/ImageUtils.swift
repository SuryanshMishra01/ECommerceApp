//
//  ImageUtils.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//


import Foundation
import SwiftUI

public func fetchAsyncImage(from url: URL) -> some View {
    AsyncImage(url: url) { phase in
        if let image = phase.image {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 120)
        } else if phase.error != nil {
            Text("Error Loading Image")
        } else {
            ProgressView()
        }
    }
}
