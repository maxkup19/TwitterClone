//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @State private var caption = ""
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var avm: AuthViewModel
    @ObservedObject var utvm = UploadTweetViewModel()
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button {
                    utvm.uploadTweet(withCaption: caption)
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = avm.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                TextArea("What's happening?", text: $caption)
                    
            }
            .padding()
        }
        .onReceive(utvm.$didUploadTweet) { success in
            if success {
                dismiss()
            } else  {
                showAlert = true
            }
            
        }
        .alert("Uploading Error",
               isPresented: $showAlert, actions: {})
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
            .environmentObject(AuthViewModel())
    }
}
