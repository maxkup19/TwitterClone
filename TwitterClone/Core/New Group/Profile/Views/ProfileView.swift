//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Max Kup on 19.08.2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @ObservedObject var pvm: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    @Namespace var animation
    
    init(user: User) {
        self.pvm = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            
            actionButtons
            
            userInfoDetails
            
            tweetFilterBar
            
            tweetsView
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: UUID().uuidString,
                               username: "batman",
                               fullname: "Bruce Wayne",
                               profileImageUrl: "",
                               email: "batman@gmail.com"))
    }
}

extension ProfileView {
    private var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x: 10, y: -4)
                }
                
                KFImage(URL(string: pvm.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
                
            }
            
        }
        .frame(height: 96)
    }
    
    private var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(.gray, lineWidth: 0.75))
            
            Button {
                // MARK: - Action
            } label: {
                Text(pvm.actionButtonTitle)
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(.primary)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 0.75))
            }
        }
        .padding(.trailing)
    }
    
    private var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(pvm.user.fullname)
                    .font(.title2).bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            
            Text("@\(pvm.user.username)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Your mom`s favourite villain")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    Text("Gotham, NY")
                }
                
                HStack {
                    Image(systemName: "link")
                    
                    Text("www.thejoker.com")
                }
            }
            .foregroundColor(.secondary)
            .font(.caption)
            
            UserStatsView()
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
    
    private var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id:\.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .bold)
                        .foregroundColor(selectedFilter == item ? .primary : .secondary)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                            
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    private var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(pvm.tweets(forFilter: self.selectedFilter)) { tweet in
                    TweetRowView(tweet: tweet)
                        .padding()
                }
            }
        }
    }
}
