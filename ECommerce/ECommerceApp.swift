//
//  ECommerceApp.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData
import FirebaseCore
internal import Combine

// Navigation
class AppState: ObservableObject{
    enum AuthScreen{
        case signup
        case login
    }
    
    @Published var isAuthenticated: Bool = false
    @Published var authScreen: AuthScreen = .login
}

@main
struct ECommerceApp: App {
    
    init(){
        FirebaseApp.configure()
    }
      
    @StateObject var homeVM = HomeViewModel()
    @StateObject var userProfileVM = UserProfileViewModel()
    @StateObject var addVM = AddressViewModel()
    @StateObject var cartVM = CartViewModel()
    @StateObject var ordersVM = OrdersViewModel()
    // app state
    @StateObject var appState = AppState()
    // Theme
    @StateObject var theme = ThemeManager()
    // Auth Service
    @StateObject var authService = AuthService()
    
 
    
    var body: some Scene {
        WindowGroup {
                RootView()
                               
            
            .environmentObject(homeVM)
            .environmentObject(userProfileVM)
            .environmentObject(appState)
            .environmentObject(cartVM)
            .environmentObject(ordersVM)
            .environmentObject(addVM)
            .environmentObject(theme)
            .environmentObject(authService)
            .preferredColorScheme(theme.isDarkMode ? .dark : .light)               // color scheme injection in app

            
            
        }
    }
    
}
