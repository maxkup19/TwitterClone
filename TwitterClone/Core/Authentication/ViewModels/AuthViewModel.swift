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
    @Published var didAuthenticateUser = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("DEBUG: current user is \(self.userSession?.uid)")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Did log user in")
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            
            print("DEBUG: Registered user succesfully")
            print("DEBUG: User is \(user.uid)")
            
            let data = ["email" : email.lowercased(),
                        "username" : username.lowercased(),
                        "fullname" : fullname,
                        "uid" : user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                    print("DEBUG: did upload user data")
                }
        }
    }
    
    func signOut() {
        // sets nil to show login view
        self.userSession = nil
        
        // signs user out on server
        try? Auth.auth().signOut()
        
        print("DEBUG: did sign user out")
    }
}
