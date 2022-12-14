//
//  LoginView.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var avm: AuthViewModel
    
    var body: some View {
        // parent container
        VStack {
            
            // header view
            AuthHeaderView(title1: "Hello.", title2: "Welcome Back")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope",
                                 placeholder: "Email",
                                 text: $email)
                CustomInputField(imageName: "lock",
                                 placeholder: "Password",
                                 isSecureField: true,
                                 text: $password)
            }
            .padding(.horizontal, 32)
            .padding(.top, 44)
            
            HStack {
                Spacer()
                
                NavigationLink {
                    Text("Reset password view...")
                } label: {
                    Text("Forgot password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .padding(.top)
                        .padding(.trailing, 24)
                }
            }
            
            Button {
                avm.login(withEmail: email,
                          password: password)
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                    
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 32)
            .foregroundColor(.blue)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
