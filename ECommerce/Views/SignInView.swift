//
//  SwiftUIView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 26/11/25.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        HStack{
            VStack{
                Text("Welcome Back !")
                    .font(.largeTitle.bold())
                    .padding(.vertical,5)
                    .foregroundColor(.secondary)
                TextField("Email", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top)
                
                    .padding(.horizontal, 8)
                
                SecureField("Password", text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                Button("Continue"){
                    
                }
                .frame(maxWidth: 250)
                .background(Color.green)
                .cornerRadius(8)
                HStack{
                    Text("New here?")
                    Text("Create an account")
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
    SwiftUIView()
}
