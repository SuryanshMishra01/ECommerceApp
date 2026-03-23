//
//  SwiftUIView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 26/11/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var profileVM: UserProfileViewModel
    private let authService = AuthService()
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        HStack{
            VStack{
                Text("Welcome Back !")
                    .font(.largeTitle.bold())
                    .padding(.vertical,5)
                    .foregroundColor(AppColors.textSecondary)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top)
                
                    .padding(.horizontal, 8)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                PrimaryButton(title: "Continue") {
                    authService.logIn(email: email, password: password) { result in
                        switch result {
                        case .success(let authResult):
                            let uid = authResult.user.uid
                            Task { @MainActor in
                                profileVM.loadProfile(uid: uid)
                            }
                            
                            // Successful Login 
                            appState.isAuthenticated = true
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                .frame(maxWidth: 250)
              
                HStack{
                    Text("New here?")
                    Button("Create an account"){
                        appState.authScreen = .signup                      // back to signup
                    }
                        .foregroundColor(.blue)
                }
                
                
            }
            .frame(maxWidth: 250)
            .padding(50)
            .padding(.bottom,50)
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
     
        
        .background(
            Image("EComm_SignIn_BG")
                .resizable()
                .scaledToFill()
                .opacity(0.8)
        )
     
    }
      
}

#Preview {
    LoginView()
}
