//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Max Kup on 24.08.2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Create your account.", title2: "Add a profile photo")
            
            Button {
                print("DEBUG: pick image here")
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .padding(.top, 44)
                    .scaledToFill()
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
