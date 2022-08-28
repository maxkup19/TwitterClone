//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var didUploadTweet = false
    
    let service = TweetService()
    
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { success in
            self.didUploadTweet = success
        }
    }
    
}
