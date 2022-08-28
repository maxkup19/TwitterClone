//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Max Kup on 28.08.2022.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            
            print("DEBUG: users \(users)")
        }
    }
}
