//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Max Kup on 19.08.2022.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var evm = ExploreViewModel()
    
    var body: some View {
        VStack {
            
            SearchBar(text: $evm.searchText)
                .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(evm.searchableUsers) { user in
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            UserRowView(user: user)
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Explore")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
