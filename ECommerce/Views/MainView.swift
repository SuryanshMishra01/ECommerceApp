//
//  MainView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI
internal import CoreData

struct MainView: View {
   @EnvironmentObject var nm: NetworkManager
    
    var body: some View {
        NavigationSplitView{
            SideBarView()
        }detail: {
            HomeView()
        }
            
    }
}

#Preview {
    MainView()
        .environmentObject(NetworkManager())
        .environmentObject(CartViewModel(context: PersistenceController.shared.container.viewContext))
}
