//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Max Kup on 18.08.2022.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
    
    let tweet: Tweet
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let user = tweet.user {
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
                        Text(tweet.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                // action buttnos
                HStack {
                    Button {
                        // MARK: - Action
                    } label: {
                        Image(systemName: "bubble.left")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Button {
                        // MARK: - Action
                    } label: {
                        Image(systemName: "arrow.2.squarepath")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Button {
                        // MARK: - Action
                    } label: {
                        Image(systemName: "heart")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Button {
                        // MARK: - Action
                    } label: {
                        Image(systemName: "bookmark")
                            .font(.subheadline)
                    }
                }
                .padding()
                .foregroundColor(.secondary)
                
                Divider()
            }
            
        }
        .padding()
    }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetRowView()
//    }
//}
