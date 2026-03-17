//
//  SigninView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI
import FirebaseAuth




struct SignUpView: View {
    
    @EnvironmentObject var profileVM: UserProfileViewModel
    @EnvironmentObject var navigation: NavigationManager
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    
    private let authService = AuthService()
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
              
                Button("Proceed") {
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
          
        }
        
        .padding(20)
        
    }
}

#Preview {
    SignUpView()
        .environmentObject(NavigationManager())
}
