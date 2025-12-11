//
//  SwiftUIView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 26/11/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var userSessionVM = UserSessionViewModel()
    @EnvironmentObject var navigation: NavigationManager
    
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
                    if userSessionVM.logIn(email: userSessionVM.email, password: userSessionVM.password){
                        navigation.navigate(to: ._main)
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
}
