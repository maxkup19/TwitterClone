//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    let tweetService = TweetService()
    let userService = UserService()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        tweetService.fetchTweets { tweets in
            self.tweets = tweets
            print("DEBUG: \(self.tweets)")
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
        }
    }
}
