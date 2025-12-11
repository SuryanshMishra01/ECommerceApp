//
//  NavigationManager.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 01/12/25.
//

import Foundation
internal import Combine
import SwiftUI


final class NavigationManager: ObservableObject{
    
    
    enum AuthFlow: Hashable, Codable{
        case _main
        case login
      case category(String)
        
    }
    
      
    
    
    @Published var currentView = NavigationPath()
    
    
    func navigate(to destination: AuthFlow){
        currentView.append(destination)
        
    }
    
    func navigateBack(){
        currentView.removeLast(1)
    }
    
    func navigateToRoot(){
        currentView.removeLast(currentView.count)
    }
}
