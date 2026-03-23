//
//  RootView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 23/03/26.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        if appState.isAuthenticated {
            MainView() // NavigationSplitView
        } else {
            
            switch appState.authScreen {
            case .signup:
                SignUpView()
            case .login:
                LoginView()
            }
        }
    }
}
