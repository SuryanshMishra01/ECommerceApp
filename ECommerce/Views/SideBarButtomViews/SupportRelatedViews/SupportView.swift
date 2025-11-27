//
//  SupportView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//

import SwiftUI

struct SupportView: View {
    @State private var showBugReport = false

    var body: some View {
        Text("Support")
            .font(.title.bold())
            .padding()
       
            List{
     
                   Button{
                            
                        }label:{
                            HStack{
                                Text("Contact Support")
                                Spacer()
                                Image(systemName: "headset")
                            }
                        }
                       Button{
                            showBugReport = true
                        }label:{
                            HStack{
                                Text("Report a bug")
                                Spacer()
                                Image(systemName: "ladybug")
                            }
                        }
                        .sheet(isPresented: $showBugReport) {
                            BugReportView()
                        }
                        Button{
                            
                        }label:{
                            HStack{
                                Text("Terms & Privacy Policy")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        Button{
                            
                        }label:{
                            HStack{
                                Text("About the app (version, build number, developer info)")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        
                    }
            .padding()

    }
}

#Preview {
    SupportView()
}
