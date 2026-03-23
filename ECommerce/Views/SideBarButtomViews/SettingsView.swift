//
//  CategoriesView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct SettingsView: View {
   @StateObject var vm = SettingsViewModel()
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var profileVM: UserProfileViewModel

    var body: some View {
        NavigationStack{
            
            
            Form{
                
                Section("Preferences") {
                    Toggle("Receive Notifications", isOn: $vm.notifications)
                    Toggle("Dark Mode", isOn: $theme.isDarkMode)
                        .padding()
                }
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
                        
                    }
                    .foregroundColor(Color.red)
                   
                }
             
            }
            .padding()
            .navigationTitle(Text("Settings"))
        }
    
    }
}

#Preview {
    SettingsView()
}
