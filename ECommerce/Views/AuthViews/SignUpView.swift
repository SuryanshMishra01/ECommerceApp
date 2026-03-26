//
//  SigninView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI
import FirebaseAuth




struct SignUpView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var profileVM: UserProfileViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var authService: AuthService
    var body: some View {
        
        HStack{
            Image("EComm_SignUp_BG")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            
            
            VStack{
                Text("WG ECommerce App")
                    .font(.largeTitle.bold())
                    .foregroundColor(AppColors.textPrimary)
                Text("Welcome to the World of ECommerce")
                    .foregroundColor(AppColors.secondary)
                HStack{
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                .padding()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                PrimaryButton(title: "Register"){
                    authService.signUp(
                        email: email,
                        password: password
                    ) { result in
                        switch result {
                        case .success(let authResult):
                            let uid = authResult.user.uid
                           Task {@MainActor in
                               
                               profileVM.createProfile(uid: uid, email: email, firstName: firstName, lastName: lastName)
                            }
                            // successful signup
                            appState.authScreen = .login

                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                .frame(width: 250)
             
                HStack{
                    Divider()
                    
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(AppColors.textSecondary)
                    
                    Text("OR")
                        .foregroundColor(AppColors.textSecondary)
                        .padding(.horizontal, 8)
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .background(AppColors.textSecondary)
                    
                    
                }
                SecondaryButton(title: "Signin existing account"){
                    // login state without signup
                    appState.authScreen = .login
                }
                .frame(width: 250)
                              
                Spacer()
                
                HStack{
                    Image(systemName: "exclamationmark.circle")
                    Text("Google and Apple ID Auth not available yet :(")
                    
                }
                .frame(width: 300, alignment: .center)
            }
            .padding()
          
        }
        
        .padding(20)
        .alert(authService.alertMessage, isPresented: $authService.showAlert) {
            Button("OK", role: .cancel) {}
        }
        
    }
}

#Preview {
    SignUpView()
}
