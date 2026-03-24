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
        case .profile: UserProfileView()

        case .home:
            NavigationStack{
                HomeView()
            }
        case .categories:
            NavigationStack{
                CategoriesView()
            }
        case .cart: CartView()
        case .settings: SettingsView()
        case .orders:
                OrdersView()
        case .support: SupportView()
            
        }
        
    }
    
}


#Preview {
    DetailView(type: .home)
}
