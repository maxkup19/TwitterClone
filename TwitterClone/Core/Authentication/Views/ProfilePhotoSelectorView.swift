//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Max Kup on 24.08.2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    
    @State private var showImagePicker = false
    @State private var image = UIImage()
    
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Setup your account.", title2: "Add a profile photo")
            
            Button {
                showImagePicker.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .padding(.top, 44)
                    .scaledToFill()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $image)
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
