//
//  ECommerceApp.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
import CoreData

@main
struct ECommerceApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var nm =  NetworkManager()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .environmentObject(nm)
                .task{
                    try? await self.nm.fetchData()

                }
        }
        
    }
}
