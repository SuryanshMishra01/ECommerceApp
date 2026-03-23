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
    @EnvironmentObject var addVM: AddressViewModel
    @State var showDetail = false
    
   
    var body: some View {
        Text("Profile")
            .font(.title.bold())
            .padding()
            .foregroundColor(AppColors.textPrimary)
        ScrollView{
            VStack(spacing: 20) {
                
                // Avatar + name
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(AppColors.textSecondary)
                    
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
                            TextField("First Name", text: $vm.firstName)
                            TextField("Last Name", text: $vm.lastName)
                            TextField("Email" , text: .constant(vm.email) )
                        }
                        
                        // MARK: Address
                        Section("Address") {

                            Button {
                                showDetail = true
                            } label: {
                                Label("Manage Addresses", systemImage: "plus.square.fill")
                            }

                            if let address = addVM.defaultAddress {

                                GroupBox("Default Address") {

                                    VStack(alignment: .leading, spacing: 6) {

                                        LabeledContent("Phone", value: address.phone)
                                        LabeledContent("Street", value: address.street)
                                        LabeledContent("City", value: address.city)
                                        LabeledContent("State", value: address.state)
                                        LabeledContent("Pincode", value: address.pincode)

                                    }
                                }

                            } else {
                                Text("No default address selected")
                                    .foregroundStyle(AppColors.textSecondary)
                            }
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
        .sheet(isPresented: $showDetail){
            AddressView()
        }
    }
}

#Preview {
    UserProfileView()
}
