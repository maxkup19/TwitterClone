//
//  UserService.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                guard let user = try? snapshot.data(as: User.self) else { return }
                print("DEBUG: username: \(user.username)")
                print("DEBUG: email: \(user.email)")
                print("DEBUG: fullname: \(user.fullname)")
                completion(user)
            }
    }
    
}
