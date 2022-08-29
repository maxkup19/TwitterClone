//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Foundation
import SwiftUI

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    private let service = TweetService()
    
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
        checkIfUserSavedTweet()
    }
    
    func likeTweet() {
        service.likeTweet(self.tweet) {
            self.tweet.didLike = true
        }
    }
    
    func unlikeTweet() {
        service.unlikeTweet(self.tweet) {
            self.tweet.didLike = false
        }
    }
    
    func checkIfUserLikedTweet() {
        service.checkIfUserLikedTweet(self.tweet) { didLike in
            if didLike {
                self.tweet.didLike = true
            }
        }
    }
    
    func saveTweet() {
        service.saveTweet(self.tweet) {
            self.tweet.didSave = true
        }
    }
    
    func unsaveTweet() {
        service.unsaveTweet(self.tweet) {
            self.tweet.didSave = false
        }
    }
    
    func checkIfUserSavedTweet() {
        service.checkIfUserSavedTweet(self.tweet) { didSave in
            if didSave {
                self.tweet.didSave = true
            }
        }
    }
}
