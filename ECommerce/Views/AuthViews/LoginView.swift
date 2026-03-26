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
    @EnvironmentObject var authService: AuthService
    @State private var errorMessage: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        HStack{
            VStack{
                VStack{
                    Text("Welcome Back !")
                        .font(.largeTitle.bold())
                        .padding(.vertical,5)
                        .foregroundColor(AppColors.textSecondary)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40) // bigger text field height
                        .padding(.top)
                        .padding(.horizontal, 8)
                        .onChange(of: email) { errorMessage = "" } // clear error when user types
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40) // bigger text field height
                        .padding(8)
                        .onChange(of: password) { errorMessage = "" } // fixed: was incorrectly using email
                }
                .frame(maxWidth: 400) // flexible width instead of fixed 350
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: 400, alignment: .leading) // align with text fields
                        .padding(.horizontal, 8)
                }
                
                HStack{
                    Text("Forgot your password?")
                        .foregroundColor(AppColors.textSecondary)
                    Button("Change Password"){
                        authService.resetPassword(email: email) { result in
                            Task { @MainActor in
                                switch result {
                                case .success:
                                    errorMessage = "Password reset email sent"
                                case .failure(let error):
                                    errorMessage = error.localizedDescription
                                }
                            }
                        }
                    }
                    .foregroundColor(.blue)
                }
            
                .font(.caption)
                .foregroundColor(.blue)
                .padding(.top, 4)
                
                // constrain button size using HStack to prevent full-width expansion
                    PrimaryButton(title: "Continue") {
                        authService.logIn(email: email, password: password) { result in
                            switch result {
                            case .success(let authResult):
                                let uid = authResult.user.uid
                                Task { @MainActor in
                                    profileVM.loadProfile(uid: uid)
                                }
                                appState.isAuthenticated = true
                                
                            case .failure(let error):
                                Task { @MainActor in
                                    self.errorMessage = error.localizedDescription
                                }
                            }
                        }
                    }
                    .frame(width: 250)

                
                
                HStack{
                    Text("New here?")
                    Button("Create an account"){
                        appState.authScreen = .signup
                    }
                    .foregroundColor(.blue)
                }
                
                
            }
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
