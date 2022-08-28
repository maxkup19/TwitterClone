//
//  User.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
}
