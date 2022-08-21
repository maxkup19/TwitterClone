//
//  SideMenuOptionRowView.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    let viewModel: SideMenuViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(viewModel.title)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionRowView(viewModel: .profile)
    }
}
