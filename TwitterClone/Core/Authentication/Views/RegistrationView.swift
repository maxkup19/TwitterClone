//
//  RegistrationView.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var username = ""
    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var avm: AuthViewModel
    
    var body: some View {
        VStack {
            
            NavigationLink(destination: ProfilePhotoSelectorView(),
                           isActive: $avm.didAuthenticateUser,
                           label: { })

            
            AuthHeaderView(title1: "Get started.",
                           title2: "Create your account")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope",
                                 placeholder: "Email",
                                 text: $email)
                CustomInputField(imageName: "person",
                                 placeholder: "Username",
                                 text: $username)
                CustomInputField(imageName: "person",
                                 placeholder: "Fullname",
                                 text: $fullname)
                CustomInputField(imageName: "lock",
                                 placeholder: "Password",
                                 isSecureField: true,
                                 text: $password)
            }
            .padding(32)

            Button {
                avm.register(withEmail: email,
                             password: password,
                             fullname: fullname,
                             username: username)
            } label: {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                    
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
