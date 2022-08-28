//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Max Kup on 18.08.2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @ObservedObject var trvm: TweetRowViewModel
    
    init(tweet: Tweet) {
        self.trvm = TweetRowViewModel(tweet: tweet)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let user = trvm.tweet.user {
                // profile image + user info + tweet
                HStack (alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                    
                    // user info & tweet caption
                    VStack(alignment: .leading, spacing: 4) {
                        
                        //user info
                        HStack {
                            Text(user.fullname)
                                .font(.subheadline).bold()
                            
                            Text("@\(user.username)")
                                .foregroundColor(.secondary)
                                .font(.caption)
                            
                            Text("2w")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        
                        // tweet caption
                        Text(trvm.tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                // action buttons
                HStack(spacing: 25) {
                    
                    Button {
                        trvm.tweet.didLike ?? false ? trvm.unlikeTweet() : trvm.likeTweet()
                    } label: {
                        Image(systemName: trvm.tweet.didLike ?? false ? "heart.fill" : "heart")
                            .font(.subheadline)
                            .foregroundColor(trvm.tweet.didLike ?? false ? .red : .secondary)
                    }
                    
                    
                    Button {
                        trvm.tweet.didSave ?? false ? trvm.unsaveTweet() : trvm.saveTweet()
                    } label: {
                        Image(systemName: trvm.tweet.didSave ?? false ? "bookmark.fill" : "bookmark")
                            .font(.subheadline)
                            .foregroundColor(trvm.tweet.didSave ?? false ? .blue : .secondary)
                    }
                    
                    Spacer()
                }
                .padding()
                .foregroundColor(.secondary)
                
                Divider()
            }
            
        }
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView(tweet: Tweet(caption: "", timestamp: Timestamp(), uid: "", likes: 2))
//    }
//}
