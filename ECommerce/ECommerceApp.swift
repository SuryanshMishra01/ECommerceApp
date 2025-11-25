//
//  ECommerceApp.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData

@main
struct ECommerceApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var nm =  NetworkManager()
    @StateObject var profileVM = ProfileViewModel(context: PersistenceController.shared.container.viewContext)
    @StateObject var cartVM = CartViewModel(context: PersistenceController.shared.container.viewContext)


    var body: some Scene {
        WindowGroup {
            MainView()
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

