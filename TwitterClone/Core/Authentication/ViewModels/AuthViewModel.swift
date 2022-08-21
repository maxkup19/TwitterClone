//
//  AuthViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: current user is \(String(describing: self.userSession))")
    }
    
    func login(withEmail email: String, password: String) {
        print("DEBUG: login with \(email)")
        // test
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        print("DEBUG: register with \(email)")
    }
}
