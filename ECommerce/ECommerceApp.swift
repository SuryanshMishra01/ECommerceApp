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

class AppState: ObservableObject{
    enum AuthScreen{
        case signup
        case login
    }
    
    @Published var isAuthenticated: Bool = false
    @Published var authScreen: AuthScreen = .signup
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
    // Navigation
    @StateObject var appState = AppState()       // app state

    @StateObject var navigation = NavigationManager()
    // Theme
    @StateObject var theme = ThemeManager()
    
 
    
    var body: some Scene {
        WindowGroup {
                RootView()
                               
            
            .environmentObject(homeVM)
            .environmentObject(userProfileVM)
            .environmentObject(navigation)
            .environmentObject(appState)
            .environmentObject(cartVM)
            .environmentObject(ordersVM)
            .environmentObject(addVM)
            .environmentObject(theme)
            .preferredColorScheme(theme.isDarkMode ? .dark : .light)               // color scheme injection in app

            
            
        }
    }
    
}
