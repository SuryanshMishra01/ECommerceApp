//
//  ThemeManager.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 23/03/26.
//

import Foundation
internal import Combine

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
}
