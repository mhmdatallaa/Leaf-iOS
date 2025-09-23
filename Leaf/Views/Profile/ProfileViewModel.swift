//
//  ProfileViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 23/09/2025.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    
    func logOut() async {
        do {
            try await AuthService.shared.signOut()
        } catch {
            Logger.shared.log("\(error)", level: .error)
        }
    }
    
    func loadCurrentUser() async {
        do {
            let user = try await AuthService.shared.getAuthenticatedUser()
            self.user = try await UserManager.shared.getUser(userId: user.uid)
        } catch {
            Logger.shared.log("error fetching user data \(error)")
        }
        
    }
}
