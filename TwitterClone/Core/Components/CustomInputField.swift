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
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.secondary)
                
                TextField(placeholder, text: $text)
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
    }
}
