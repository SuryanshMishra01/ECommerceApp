//
//  AppButtons.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 23/03/26.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.primary)
                .cornerRadius(10)
        }
    }
}
