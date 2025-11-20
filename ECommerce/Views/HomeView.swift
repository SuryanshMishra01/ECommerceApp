//
//  ContentView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var nm = NetworkManager()
    
    var body: some View {
        Text("ECommerce Application")
        NavigationStack{
            VStack{
                HStack{
                    NavigationLink{
                        CategoryItemsView(nm: nm, category: K.Category.beauty)
                    }label:{
                        VStack{
                            CategoryFirstImageView(nm: nm, category: K.Category.beauty)
                            Text("Beauty Products")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                    NavigationLink{
                        CategoryItemsView(nm: nm, category: K.Category.grocery)
                    }label:{
                        VStack{
                            CategoryFirstImageView(nm: nm, category: K.Category.grocery)
                            Text("Groceries")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                }
                HStack{
                    NavigationLink{
                        CategoryItemsView(nm: nm, category: K.Category.fragrance)
                    }label:{
                        VStack{
                            CategoryFirstImageView(nm: nm, category: K.Category.fragrance)
                            Text("Fragrances")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                    NavigationLink{
                        CategoryItemsView(nm: nm, category: K.Category.furniture)
                    }label:{
                        VStack{
                            CategoryFirstImageView(nm: nm, category: K.Category.furniture)
                            Text("Furnitures")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                }
            }
            
            .task {
                try? await self.nm.fetchData()
            }
          
          
        }
      
    }
       
}

#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
}
