//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Max Kup on 19.08.2022.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.username)
                    .font(.subheadline).bold()
                    .foregroundColor(.primary)
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(id: UUID().uuidString,
                               username: "batman",
                               fullname: "Bruce Wayne",
                               profileImageUrl: "",
                               email: "batman@gmail.com"))
    }
}
