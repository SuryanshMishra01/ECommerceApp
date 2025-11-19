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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
