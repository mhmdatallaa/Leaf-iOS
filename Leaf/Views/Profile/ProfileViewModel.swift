//
//  ProfileViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 23/09/2025.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    func logOut() async {
        do {
            try await AuthService.shared.signOut()
        } catch {
            Logger.shared.log("\(error)", level: .error)
        }
    }
}
