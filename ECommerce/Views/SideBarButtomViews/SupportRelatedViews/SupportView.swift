//
//  SupportView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        VStack{
            
            Text("Support")
                .font(.title.bold())
            
            
            VStack(alignment: .leading){
                NavigationLink{
                    
                }label:{
                    HStack{
                        Text("Contact Support")
                        Spacer()
                        Image(systemName: "headset")
                    }
                }
                NavigationLink{
                    BugReportView()
                }label:{
                    HStack{
                        Text("Report a bug")
                        Spacer()
                        Image(systemName: "ladybug")
                    }
                }
                NavigationLink{
                    
                }label:{
                    HStack{
                        Text("Terms & Privacy Policy")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                NavigationLink{
                    
                }label:{
                    HStack{
                        Text("About the app (version, build number, developer info)")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                
            }
            .padding(.leading, 50)
            .padding(.trailing, 100)
        }
        .padding()
    }
}

#Preview {
    SupportView()
}
