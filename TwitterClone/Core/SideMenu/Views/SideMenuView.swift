//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Max Kup on 19.08.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @EnvironmentObject var avm: AuthViewModel
    
    var body: some View {
        if let user = avm.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    UserStatsView()
                        .padding(.vertical)
                    
                }
                .padding(.leading)
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { option in
                    
                    if option == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionRowView(viewModel: option)
                        }
                    } else if option == .logout {
                        Button {
                            avm.signOut()
                        } label: {
                            SideMenuOptionRowView(viewModel: option)
                        }
                    } else if option == .bookmarks {
                        NavigationLink {
                            ProfileView(user: user, selectedFilter: .saved)
                        } label: {
                            SideMenuOptionRowView(viewModel: option)
                        }
                    } else {
                        SideMenuOptionRowView(viewModel: option)
                    }
                    
                    
                }
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
            .environmentObject(AuthViewModel())
    }
}

