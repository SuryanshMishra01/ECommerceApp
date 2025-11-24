//
//  ProfileView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct ProfileView: View {
   
    @StateObject private var vm: ProfileViewModel
    
    
    init(){
        _vm = StateObject(wrappedValue: ProfileViewModel(context: PersistenceController.shared.container.viewContext))
    }

    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                
                // Avatar + name
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.gray)
                    
                    Text(vm.fullName)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                Form {
                    
                    // MARK: Account Info
                    Section("Account Information") {
                        TextField("Full Name", text: $vm.fullName)
                        TextField("Email", text: $vm.email)
                        TextField("Phone", text: $vm.phone)
                    }
                    
                    // MARK: Address
                    Section("Address") {
                        TextField("Street", text: $vm.street)
                        TextField("City", text: $vm.city)
                        TextField("Pincode", text: $vm.pincode)
                    }
                    
                    // MARK: Preferences
                    Section("Preferences") {
                        Toggle("Receive Notifications", isOn: $vm.notifications)
                        Toggle("Dark Mode", isOn: $vm.darkMode)
                    }
                }
                .frame(maxWidth: 450)
                
                Spacer()
                
                // MARK: Buttons
                HStack(spacing: 20) {
                    Button("Save") {
                        vm.saveChanges()
                    }
                    .keyboardShortcut(.defaultAction)
                    .buttonStyle(.borderedProminent)
                    
                    Button("Reset Changes") {
                        vm.resetChanges()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top)
            }
            .padding(30)
        }
    }
}

#Preview {
    ProfileView()
}
