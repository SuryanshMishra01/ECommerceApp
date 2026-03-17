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
    }
    enum InternalFlow: Hashable, Codable {
//        case categories
        case productDetail(Int)
//        case orderDetail(UUID)
    }
    
    
    
    @Published var authPath = NavigationPath()                   // for Auth Flow
    @Published var internalPath = NavigationPath()               // for internal views like category
    
    
    
      // MARK: Navigate Forward
      
      func navigate(to route: AuthFlow) {
          authPath.append(route)
      }

      func navigate(to route: InternalFlow) {
          internalPath.append(route)
      }

      
      // MARK: Navigate Back
      
      func navigateBackAuth() {
          if !authPath.isEmpty {
              authPath.removeLast()
          }
      }

      func navigateBackInternal() {
          if !internalPath.isEmpty {
              internalPath.removeLast()
          }
      }

      
      // MARK: Navigate To Root
      
      func navigateAuthToRoot() {
          authPath.removeLast(authPath.count)
      }

      func navigateInternalToRoot() {
          internalPath.removeLast(internalPath.count)
      }
}
