//
//  CategoriesView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct SettingsView: View {
   @StateObject var vm = SettingsViewModel()
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        Text("Settings")
            .font(.title)
            .fontWeight(.bold)
            .padding()
        
        Form{
            
            Section("Preferences") {
                Toggle("Receive Notifications", isOn: $vm.notifications)
                Toggle("Dark Mode", isOn: $vm.darkMode)
            }
            Section("Account"){
                HStack{
                    VStack(alignment: .leading){
                        Text(profileVM.fullName)
                        Text(profileVM.email)
                            
                    }
             
                NavigationLink("Edit"){
                        ProfileView()
                         
                    }
                }
                Button("Change Password"){
                    
                }
                Spacer()
                Button("Logout"){
                    
                }
                .foregroundColor(Color.red)
                .padding()
            }
        }
    }
}

#Preview {
    CategoriesView()
}
