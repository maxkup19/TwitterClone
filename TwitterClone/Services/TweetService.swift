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
                    "saved": 0,
                    "timestamp": Timestamp(date: Date())] as [String : Any]
        
        Firestore.firestore().collection("tweets").document()
            .setData(data) { err in
                if let err = err {
                    print("DEBUG: failed to upload tweet with error \(err.localizedDescription)")
                    completion(false)
                    return
                }
                
                completion(true)
            }
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
                print("DEBUG: did fetch tweets succefully")
                completion(tweets)
            }
    }
    
    func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let tweets = documents.compactMap { try? $0.data(as: Tweet.self) }
                completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
}

// MARK: - Likes

extension TweetService {
    
    func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes + 1]) { _ in
                userLikesRef.document(tweetId)
                    .setData([:]) { _ in
                        print("DEBUG: did like tweet successfully")
                        completion()
                    }
            }
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes": tweet.likes - 1]) { _ in
                userLikesRef.document(tweetId)
                    .delete { _ in
                        print("DEBUG: did unlike tweet successfully")
                        completion()
                    }
            }
    }
    
    func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                completion(snapshot.exists)
            }
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = Set<Tweet>()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else  { return }

                documents.forEach { doc in
                    let tweetId = doc.documentID

                    Firestore.firestore().collection("tweets")
                        .document(tweetId)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }

                            tweets.insert(tweet)
                            completion(Array(tweets).sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                        }
                }
            }
    }
    
}


// MARK: - Saved twits

extension TweetService {
    
    func saveTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userSavedRef = Firestore.firestore().collection("users").document(uid).collection("user-saved")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["saved": tweet.saved + 1]) { _ in
                userSavedRef.document(tweetId)
                    .setData([:]) { _ in
                        completion()
                    }
            }
    }
    
    func unsaveTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.saved > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-saved")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["saved": tweet.saved - 1]) { _ in
                userLikesRef.document(tweetId)
                    .delete { _ in
                        completion()
                    }
            }
    }
    
    func checkIfUserSavedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saved")
            .document(tweetId)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                completion(snapshot.exists)
            }
    }
    
    func fetchSavedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = Set<Tweet>()
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-saved")
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else  { return }

                documents.forEach { doc in
                    let tweetId = doc.documentID

                    Firestore.firestore().collection("tweets")
                        .document(tweetId)
                        .getDocument { snapshot, _ in
                            guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }

                            tweets.insert(tweet)
                            completion(Array(tweets).sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                        }
                }
            }
    }
    
}
