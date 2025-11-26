//
//  SigninView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 25/11/25.
//

import SwiftUI

struct SignUpView: View {
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
                
                Text("Create User Account")
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 8)
                    .padding(.top, 20)
                TextField("Email", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top,5)
                    .padding(.leading)
                    .padding(.trailing)
                
                
                SecureField("Password", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Proceed"){
                    
                }
                .frame(maxWidth: 250)
                .background(Color.blue)
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
                .frame(width: 320, alignment: .center)
            }
            .padding()
        }
    }
}
    #Preview {
        SignUpView()
    }
