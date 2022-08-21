//
//  ContentView.swift
//  TwitterClone
//
//  Created by Max Kup on 18.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showMenu = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
                .navigationBarHidden(showMenu)
            
            
            if showMenu {
                ZStack {
                    Color.black
                        .opacity(showMenu ? 0.25 : 0.0)
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            
            SideMenuView()
                .frame(width: 300)
                .offset(x: showMenu ? 0 : -300, y: 0)
                .background(showMenu ? (colorScheme == .dark ? Color.black : Color.white) : Color.clear)
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation(.easeInOut) {
                        showMenu.toggle()
                    }
                } label: {
                    Circle()
                        .frame(width: 32, height: 32)
                }
            }
        }
        .onAppear {
            showMenu = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
