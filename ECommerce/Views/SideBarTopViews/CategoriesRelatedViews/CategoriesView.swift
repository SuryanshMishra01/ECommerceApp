//
//  ContentView.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 19/11/25.
//

import SwiftUI
internal import CoreData

struct CategoriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var nm: NetworkManager
    
    var body: some View {
        NavigationStack{
     
            List{
                    NavigationLink{
                        CategoryItemsView(category: K.Category.beauty)
                    }label:{
                        VStack{
                            CategoryFirstImageView(category: K.Category.beauty)
                            Text("Beauty Products")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                    NavigationLink{
                        CategoryItemsView(category: K.Category.grocery)
                    }label:{
                        VStack{
                            CategoryFirstImageView(category: K.Category.grocery)
                            Text("Groceries")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                
                
                    NavigationLink{
                        CategoryItemsView(category: K.Category.fragrance)
                    }label:{
                        VStack{
                            CategoryFirstImageView(category: K.Category.fragrance)
                            Text("Fragrances")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
                    NavigationLink{
                        CategoryItemsView(category: K.Category.furniture)
                    }label:{
                        VStack{
                            CategoryFirstImageView(category: K.Category.furniture)
                            Text("Furnitures")
                                .foregroundColor(Color.white)
                        }
                        .padding()
                    }
            
                
            }
            
         
          
            .navigationTitle(Text("Categories"))
        }
      
    }
       
}

#Preview {
    CategoriesView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        
}
