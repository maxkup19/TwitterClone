//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Max Kup on 18.08.2022.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
    
    @StateObject var avm = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(avm)
            }
        }
    }
}
