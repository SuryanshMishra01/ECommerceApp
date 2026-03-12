//
//  SideBarView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI


enum Menu: String, CaseIterable, Identifiable {
    case profile = "Profile"
    case home = "Home"
    case categories = "Categories"
    case cart = "Your Cart"
    case orders = "Your Orders"
    case settings = "Settings"
    case support = "Support"

    var id: String { rawValue }

    var icon: String {
        switch self {
            case .profile: return "person.crop.circle"
            case .home: return "house"
            case .categories: return "list.bullet"
            case .cart: return "cart"
            case .orders: return "bag"
            case .settings: return "gearshape"
            case .support: return "questionmark.circle"
        }
    }
}



struct SideBarView: View {
    @Binding var selected: Menu?

    var body: some View {
        List(Menu.allCases, id: \.self, selection: $selected) { menuItem in
            Label(menuItem.rawValue, systemImage: menuItem.icon)
                .tag(menuItem)
        }
        .listStyle(SidebarListStyle())
    }
}


#Preview {
    SideBarView(selected: .constant(.home))
}
