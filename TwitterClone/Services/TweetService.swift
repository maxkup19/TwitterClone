//
//  TweetService.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Firebase

struct TweetService {
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { err in
                if let err = err {
                    print("DEBUG: failed to upload tweet with error \(err.localizedDescription)")
                    completion(false)
                    return
                }
                
                print("DEBUG: did upload tweet succesfully")
                completion(true)
            }
        
    }
    
}
