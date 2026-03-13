//
//  ECommerceApp.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData
import FirebaseCore
internal import Combine

@main
struct ECommerceApp: App {
    
    init(){
        FirebaseApp.configure()
    }
      
    @StateObject var homeVM = HomeViewModel()
    @StateObject var userProfileVM = UserProfileViewModel()
    @StateObject var cartVM = CartViewModel()
    //Navigation
    @StateObject var navigation = NavigationManager()
    
 
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.currentView){
                SignUpView()
                    .navigationDestination(for: NavigationManager.AuthFlow.self) { route in
                        
                        switch route {

                        case .login:
                            LoginView()

                        case ._main:
                            MainView()

                        case .category(let cat):
                            CategoriesView()
                        }

                        
                    }
            }
                    
            }
            .environmentObject(homeVM)
            .environmentObject(userProfileVM)
            .environmentObject(navigation)
            .environmentObject(cartVM)
            
          
        }
    
}
