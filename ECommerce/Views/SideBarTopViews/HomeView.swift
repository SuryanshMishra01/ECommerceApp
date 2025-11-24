//
//  HomeView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 21/11/25.
//



import SwiftUI

struct HomeView: View {
    @EnvironmentObject var nm: NetworkManager
 
    var body: some View {
        ItemListiew(list: nm.products)
    
    }
}

#Preview {
    HomeView()
        
}
