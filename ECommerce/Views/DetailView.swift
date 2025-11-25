//
//  DetailView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//





import SwiftUI



struct DetailView: View {
    
    let type: Menu
    
    var body: some View {
       
        switch type{
        case .profile: ProfileView()

        case .home: HomeView()
        case .categories: CategoriesView()
        case .cart: CartsView()
        case .settings: SettingsView()
        case .orders: OrdersView()
        
        case .support: SupportView()
            
        }
        
    }
    
}


#Preview {
    DetailView(type: .home)
}
