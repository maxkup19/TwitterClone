//
//  CustomInputField.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI

struct CustomInputField: View {
    
    let imageName: String
    let placeholder: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.secondary)
                
                if isSecureField ?? false {
                    SecureField(placeholder,
                                text: $text)
                } else  {
                    TextField(placeholder, text: $text)
                }
                    
            }
            Divider()
                .background(Color.secondary)
        }
    }
}

struct CustomInputField_Prewies: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope",
                        placeholder: "Email",
                        text: .constant(""))
        .previewLayout(.sizeThatFits)
        CustomInputField(imageName: "lock",
                        placeholder: "Password",
                        isSecureField: true,
                        text: .constant(""))
        .previewLayout(.sizeThatFits)
    }
}
