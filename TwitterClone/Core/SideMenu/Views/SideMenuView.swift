//
//  SideMenuView.swift
//  TwitterClone
//
//  Created by Max Kup on 19.08.2022.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading) {
                Circle()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bruce Wayne")
                        .font(.headline)
                    
                    Text("@batman")
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
                        ProfileView()
                    } label: {
                        SideMenuOptionRowView(viewModel: option)
                    }
                } else if option == .logout {
                    Button {
                        print("Hadle logout here")
                    } label: {
                        SideMenuOptionRowView(viewModel: option)
                    }
                } else  {
                    SideMenuOptionRowView(viewModel: option)
                }
                
                
            }
            Spacer()
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

