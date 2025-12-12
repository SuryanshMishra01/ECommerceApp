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





class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
      
      FirebaseApp.configure()
  }
}





@main
struct ECommerceApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    
    @StateObject var nm: NetworkManager
    @StateObject var profileVM: ProfileViewModel
    @StateObject var cartVM: CartViewModel
    
    //Navigation
    
    @StateObject var navigation = NavigationManager()
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        
        // Create independent objects first
        let networkManager = NetworkManager()
        _nm = StateObject(wrappedValue: networkManager)
        
        let profile = ProfileViewModel(context: context)
        _profileVM = StateObject(wrappedValue: profile)
        
        let cart = CartViewModel(context: context, nm: networkManager)
        _cartVM = StateObject(wrappedValue: cart)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.currentView) {
                SignUpView()
                    .navigationDestination(for: NavigationManager.AuthFlow.self) { destination in
                        switch destination {
                        case .login:
                            LoginView()
                        case ._main:
                            MainView()
                        case .category(let cat):
                            CategoryItemsView(category: cat)
                        }
                    }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(nm)
            .environmentObject(cartVM)
            .environmentObject(profileVM)
            .environmentObject(navigation)
                
                    .task {
                        try? await nm.fetchData()
                    }
          
        }
    }
}
