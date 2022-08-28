//
//  SavedTweetsView.swift
//  TwitterClone
//
//  Created by Max Kup on 29.08.2022.
//

import SwiftUI

struct SavedTweetsView: View {
    
    @ObservedObject var stvm = SavedTweetsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(stvm.savedTweets) { tweet in
                    TweetRowView(tweet: tweet)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct SavedTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedTweetsView()
        }
    }
}
