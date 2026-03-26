//
//  CategoriesView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var showLogoutConfirmation: Bool = false
    
    @StateObject var vm = SettingsViewModel()
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var profileVM: UserProfileViewModel
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var homeVM: HomeViewModel
    
    

    var body: some View {
        NavigationStack{
            
            
            Form{
                
                Section("Preferences") {
                    Toggle("Receive Notifications", isOn: $vm.notifications)
                    Toggle("Dark Mode", isOn: $theme.isDarkMode)
                }
                .padding()

                Section("Account"){
                   
                        VStack(alignment: .leading){
                            Text(profileVM.firstName)
                            Text(profileVM.email)
                            
                        }
                        
                        NavigationLink("Edit"){
                           UserProfileView()
                            
                        }
                    
                    Button("Change Password"){
                        
                    }
                    Spacer()
                    Button("Logout"){
                       showLogoutConfirmation = true
                    }
                    .foregroundColor(Color.red)
                   
                }
                .padding()

             
            }
           
        }
        .navigationTitle(Text("Settings"))
        .confirmationDialog(
            "Are you sure you want to logout?",
            isPresented: $showLogoutConfirmation,
            titleVisibility: .visible
        ) {
            Button("Logout", role: .destructive) {
                appState.isAuthenticated = false
                appState.authScreen = .login
            }
            
            Button("Cancel", role: .cancel) { }
        }
    }
}

#Preview {
    SettingsView()
}
