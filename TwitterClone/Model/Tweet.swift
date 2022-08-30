//
//  Tweet.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var saved: Int
    
    var user: User?
    var didLike: Bool? = false
    var didSave: Bool? = false
    
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(caption)
        hasher.combine(timestamp)
        hasher.combine(uid)
    }
}
