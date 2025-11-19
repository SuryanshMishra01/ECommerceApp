//
//  ContentView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var nm = NetworkManager()

    var body: some View {
        List(nm.products, id: \.id) { product in
            HStack {
                Text(product.title)
                Spacer()
                Text("$\(product.price, specifier: "%.2f")")
            }
        }
        .task {
            try? await self.nm.fetchData()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
