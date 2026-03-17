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
                            TextField("First Name", text: $vm.firstName)
                            TextField("Last Name", text: $vm.lastName)
                            TextField("Email" , text: .constant(vm.email) )
                        }
                        
                        // MARK: Address
                            Button{
                                showDetail = true
                            }label:{
                                HStack{Text("Address")
                                    Image(systemName: "plus.square.fill")
                                }
                            }
                        if let address = addVM.defaultAddress {
                            VStack{
                                Text("Phone: \(address.phone)")
                                Text("Street: \(address.street)")
                                HStack{
                                Text("City: \(address.city)")
                                Text("State: \(address.state)")
                                }

                                Text("Pincode: \(address.pincode)")
                                
                            }
                            .font(.body)
                        } else {
                            
                            Text("No default address selected")
                                .foregroundColor(.secondary)

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
