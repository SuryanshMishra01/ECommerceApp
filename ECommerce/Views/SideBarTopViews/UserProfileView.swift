//
//  ProfileView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI
internal import CoreData

struct UserProfileView: View {
   
    @EnvironmentObject  var vm: UserProfileViewModel
    
    
   
    var body: some View {
        Text("Profile")
            .font(.title.bold())
            .padding()
        ScrollView{
            VStack(spacing: 20) {
                
                // Avatar + name
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.gray)
                    
                    Text(vm.profile?.firstName ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(vm.profile?.lastName ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                
                Divider()
                    Form {
                        
                        
                        // MARK: Account Info
                        Section("Account Information") {
                            TextField("Full Name", text: $vm.firstName)
                            TextField("Full Name", text: $vm.lastName)
                            TextField("Email" , text: .constant(vm.email) )
                            TextField("Phone", text: $vm.phone)
                        }
                        
                        // MARK: Address
                        Section("Address") {
                            TextField("Street", text: $vm.street)
                            TextField("City", text: $vm.city)
                            TextField("Pincode", text: $vm.pincode)
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
    UserProfileView()
}
