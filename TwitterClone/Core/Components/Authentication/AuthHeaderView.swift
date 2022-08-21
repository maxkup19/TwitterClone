//
//  AuthHeaderView.swift
//  TwitterClone
//
//  Created by Max Kup on 21.08.2022.
//

import SwiftUI

struct AuthHeaderView: View {
    
    let title1: String
    let title2: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .padding(.leading)
        .frame(width: UIScreen.main.bounds.width, height: 260, alignment: .leading)
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "Hello.", title2: "Welcome Back")
    }
}
