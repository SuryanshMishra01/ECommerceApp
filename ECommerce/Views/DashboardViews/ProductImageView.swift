//
//  ProductImageView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 10/03/26.
//

import SwiftUI
import NukeUI

struct ProductImageView: View {

    let url: String
    var height: CGFloat = 120
    var contentMode: ContentMode = .fit

    var body: some View {

        LazyImage(url: URL(string: url)) { state in

            if let image = state.image {

                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)

            } else if state.isLoading {

                ProgressView()

            } else {

                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(AppColors.textSecondary)
                    .padding()
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(AppColors.textSecondary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
