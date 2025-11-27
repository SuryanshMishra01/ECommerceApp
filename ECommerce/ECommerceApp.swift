//
//  ECommerceApp.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData
import FirebaseCore





class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
      
      FirebaseApp.configure()
  }
}


enum AppRoute: Hashable {
    case main
      
}


@main
struct ECommerceApp: App {
    
    // register app delegate for Firebase setup
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate


    let persistenceController = PersistenceController.shared
    @StateObject var nm =  NetworkManager()
    @StateObject var profileVM = ProfileViewModel(context: PersistenceController.shared.container.viewContext)
    @StateObject var cartVM = CartViewModel(context: PersistenceController.shared.container.viewContext)


    var body: some Scene {
        WindowGroup {
            SignUpView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .environmentObject(nm)
                .environmentObject(cartVM)
                .environmentObject(profileVM)
                .task{
                    try? await self.nm.fetchData()

                }
        }
        
    }
}

