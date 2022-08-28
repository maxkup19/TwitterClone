//
//  SavedTweetsViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 29.08.2022.
//

import Foundation

class SavedTweetsViewModel: ObservableObject {
    @Published var savedTweets = [Tweet]()
    
    private let tweetService = TweetService()
    private let userService = UserService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchSavedTweets()
    }
    
    func fetchSavedTweets() {
        guard let uid = user.id else {  return }
        
//        tweetService.fetchLikedTweets(forUid: uid) { tweets in
//            self.likedTweets = tweets
//            print(self.likedTweets)
//            
//            for i in 0 ..< tweets.count {
//                let uid = tweets[i].uid
//                self.userService.fetchUser(withUid: uid) { user in
//                    self.likedTweets[i].user = user
//                }
//            }
        }
    }
}
