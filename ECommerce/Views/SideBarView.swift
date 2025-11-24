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
    
    @State private var selected: Menu = .home
    @EnvironmentObject var nm: NetworkManager
    
    var body: some View {
        List(Menu.allCases, id: \.self){ menuItem in
            
            NavigationLink(destination:DetailView(type: menuItem)){
                HStack{
                    Text(menuItem.rawValue)
                        .font(.headline)
                    Spacer()
                    switch  menuItem{
                        case .profile:
                            Image(systemName: "person.crop.circle")
                    case .home:
                            Image(systemName: "house")
                        case .cart:
                            Image(systemName: "cart")
                        case .orders:
                            Image(systemName: "bag")
                      
                        case .categories:
                            Image(systemName: "list.bullet")
                        case .settings:
                            Image(systemName: "gearshape")
                        case .support:
                            Image(systemName: "questionmark.circle")
                    }
               
                   
                }
             
                
            }
        }
       
        
    }

}

#Preview {
    SideBarView()
        .environmentObject(NetworkManager())
}
