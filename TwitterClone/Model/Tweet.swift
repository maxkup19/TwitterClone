//
//  Tweet.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Codable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
}
