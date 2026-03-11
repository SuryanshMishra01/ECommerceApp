//
//  SessionManager.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 11/03/26.
//


import Foundation
import FirebaseAuth
internal import Combine

class SessionManager: ObservableObject {

    @Published var userID: String?

    static let shared = SessionManager()

    init() {
        self.userID = Auth.auth().currentUser?.uid
    }

    func setUser(id: String) {
        self.userID = id
    }

    func logout() {
        userID = nil
    }
}
