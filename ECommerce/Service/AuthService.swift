//
//  AuthService.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 11/03/26.
//
    

import Foundation
import SwiftUI
import os
import FirebaseAuth
internal import Combine

class AuthService: ObservableObject{
    let logger = Logger(subsystem: "com.wg.ECommerce", category: "userSession")
    
    @Published var currentUserID: UUID? = nil
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill all the fields"
            showAlert = true
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"Missing fields"])))
            return

        }
        else if !isValidEmail(email) {
            alertMessage = "Please enter a valid email"
            showAlert = true
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"Wrong fields"])))
            return
        }
        else if !isValidPassword(password) {
            alertMessage = "Password should be at least 8 characters long"
            showAlert = true
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey: "Short Password"])))
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
            if let error = error {
                Task{ @MainActor in
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
                completion(.failure(error))
                return
            
            }
            if let auth = authResult {
                self.logger.info("User created: \(auth.user.email ?? "")")
                SessionManager.shared.setUser(id: auth.user.uid)
                completion(.success(auth))
            }
          
              

        }
        
        
    }

    
    
    
    func logIn(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void) {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill all the fields"
            showAlert = true
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"Missing fields"])))
            return
        }
        else if !isValidEmail(email) {
            alertMessage = "Please enter a valid email"
            showAlert = true
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"Wrong fields"])))
            return
        }
        else if !isValidPassword(password) {
            alertMessage = "Password should be at least 8 characters long"
            showAlert = true
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey: "Short Password"])))
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
                completion(.failure(error))
                
                return
            }
    
          
             
            if let auth = authResult{
                print("User created: \(auth.user.email ?? "")")
                SessionManager.shared.setUser(id: auth.user.uid)
                completion(.success(auth))
            }
           
           
        }
      
        
        
    }
    
    //MARK: - Helpers
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
   
}
