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
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    private let userService = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: current user is \(String(describing: self.userSession?.uid))")
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: did log user in")
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            print("DEBUG: registered user succesfully")
            print("DEBUG: user is \(user.uid)")
            
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
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl" : profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        userService.fetchUser(withUid: uid) { user in
            print("DEBUG: fetched user data: \(user)")
            self.currentUser = user
        }
    }
    
}
