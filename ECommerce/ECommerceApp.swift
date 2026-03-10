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
    
    @StateObject var homeVM = HomeViewModel()
  
    //Navigation
    
    @StateObject var navigation = NavigationManager()
    
 
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.currentView) {
                SignUpView()
                    .navigationDestination(for: NavigationManager.AuthFlow.self) { destination in
                        switch destination {
                        case .login:
                            LoginView()
                        case ._main:
                            HomeView()
                        case .category(let cat):
                            CategoryItemsView(category: cat)
                        }
                    }
            }
            .environmentObject(homeVM)
            .environmentObject(navigation)
                
                    .task {
                        try? await nm.fetchData()
                    }
          
        }
    }
}
