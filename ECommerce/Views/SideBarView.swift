//
//  SideBarView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI


enum Menu: String, CaseIterable, Identifiable{
    
    case profile = "Profile"
    case home = "Home"
    case categories = "Categories"
    case cart = "Your Cart"
    case orders = "Your Orders"
    case settings = "Settings"
    case support = "Support"
    
    var id: String {rawValue}
}


struct SideBarView: View {
    
    @State private var selected: Menu? = .home
    
    
    var body: some View {
        NavigationSplitView{
            List(Menu.allCases, selection: $selected){item in
                Text(item.rawValue)
            }
            
        }detail: {
            DetailView(type: selected!)
        }
        
        
    }
}

#Preview {
    SideBarView()
}
