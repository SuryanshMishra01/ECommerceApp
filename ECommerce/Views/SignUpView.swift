//
//  SigninView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI
import FirebaseAuth




struct SignUpView: View {
    @StateObject var userSessionVM = UserSessionViewModel()
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        
        HStack{
            Image("EComm_SignUp_BG")
                .resizable()
            
                .scaledToFit()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            
            
            VStack{
                Text("WG ECommerce App")
                    .font(.largeTitle.bold())
                Text("Welcome to theWorld of ECommerce")
                    .foregroundColor(Color.blue)
                TextField("Email", text: $userSessionVM.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                
                
                SecureField("Password", text: $userSessionVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Proceed") {
                    userSessionVM.signUp(
                        email: userSessionVM.email,
                        password: userSessionVM.password
                    ) { result in
                        switch result {
                        case .success(let authResult):
                            let uid = authResult.user.uid
                            let email = authResult.user.email ?? ""

                            DispatchQueue.main.async {
                                profileVM.loadProfile(byUID: uid, byEmail: email)
                            }
                            navigation.navigate(to: ._main)

                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                .frame(width: 250)

                .background(Color.green)
                .cornerRadius(8)
                
                HStack{
                    Divider()
                    
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(Color.gray)
                    
                    Text("OR")
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 8)
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(Color.gray)
                    
                    
                }
                Button("Signin existing account"){
                    navigation.navigate(to: .login)
                }
                .frame(width: 250)
                .background(Color.blue)
                .cornerRadius(8)
                
                Spacer()
                
                HStack{
                    Image(systemName: "exclamationmark.circle")
                    Text("Google and Apple ID Auth not available yet :(")
                    
                }
                .frame(width: 300, alignment: .center)
            }
            .padding()
            .alert(userSessionVM.alertMessage, isPresented: $userSessionVM.showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        
        .padding(20)
        
    }
}

#Preview {
    SignUpView()
        .environmentObject(NavigationManager())
}
