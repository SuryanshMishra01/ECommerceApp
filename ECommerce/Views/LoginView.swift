//
//  SwiftUIView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 26/11/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @StateObject var userSessionVM = UserSessionViewModel()
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        HStack{
            VStack{
                Text("Welcome Back !")
                    .font(.largeTitle.bold())
                    .padding(.vertical,5)
                    .foregroundColor(.secondary)
                TextField("Email", text: $userSessionVM.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top)
                
                    .padding(.horizontal, 8)
                
                SecureField("Password", text: $userSessionVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                Button("Continue"){
                    userSessionVM.logIn(
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
                .frame(maxWidth: 250)
                .background(Color.green)
                .cornerRadius(8)
                HStack{
                    Text("New here?")
                    Button("Create an account"){
                        navigation.navigateBack()
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
        .environmentObject(NavigationManager())
}
