//
//  ContentView.swift
//  TwitterClone
//
//  Created by Max Kup on 18.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showMenu = false
    @EnvironmentObject var avm: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            // no user signed in
            if avm.userSession == nil {
                LoginView()
            } else {
                // have user
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .environmentObject(AuthViewModel())
        }
    }
}

extension ContentView {
    var mainInterfaceView: some View {
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
