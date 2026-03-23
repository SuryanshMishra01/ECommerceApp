//
//  MainView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI
internal import CoreData


struct MainView: View {
    
    @State private var selectedMenu: Menu = .home

    var body: some View {
        NavigationSplitView {
            SideBarView(selected: $selectedMenu)
        } detail: {
            DetailView(type: selectedMenu)
        }
    }
    
}


#Preview {
    MainView()
}
