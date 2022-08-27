//
//  User.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
}
