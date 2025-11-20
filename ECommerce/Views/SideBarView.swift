//
//  SideBarView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import SwiftUI

struct SideBarView: View {
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink{
                    
                }label: {
                    Text("Search by Category")
                }
                NavigationLink{
                    
                }label: {
                    Text("Search by Brand")
                }
                NavigationLink{
                    
                }label: {
                    Text("Search by Tags")
                }
                Spacer()
                NavigationLink{
                    
                }label: {
                    Text("Account")
                }
                NavigationLink{
                    
                }label: {
                    Text("Help")
                }
                NavigationLink{
                    
                }label: {
                    Text("Logout")
                        .foregroundColor(Color.red)
                }
            }
        }
    }
}

#Preview {
    SideBarView()
}
