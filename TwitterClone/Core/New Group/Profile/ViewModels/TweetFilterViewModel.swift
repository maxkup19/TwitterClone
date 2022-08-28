//
//  TweetFilterViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 19.08.2022.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets
    case likes
    case saved
    
    var title: String {
        switch self {
        case .tweets:
            return "Tweets"
        case .likes:
            return "Likes"
        case .saved:
            return "Saved"
        }
    }
}
