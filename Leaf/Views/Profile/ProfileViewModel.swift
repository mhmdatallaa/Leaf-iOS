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
    @Published private(set) var readingbooks: [UserBook] = []
    @Published private(set) var wantToReadBooks: [UserBook] = []
    @Published private(set) var readBooks: [UserBook] = []
    @Published private(set) var favoriteBooks: [UserBook] = []
    
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
    
    func loadUserCollection(collection: UserColletion) async {
        do {
            let authDataResult = try await AuthService.shared.getAuthenticatedUser()
            let userBooks = try await collection.getUserFavoriteBooks(userID: authDataResult.uid)
            switch collection {
            case .favorites: self.favoriteBooks = userBooks
            case .read: self.readBooks = userBooks
            case .wantToRead: self.wantToReadBooks = userBooks
            case .reading: self.readingbooks  = userBooks
            }
        } catch {
            Logger.shared.log("Couldn't get \(collection.displayName) collection")
        }
    }
    
    func removeBookFromCollection(collection: UserColletion, bookID: String) async {
        do {
            let authDataResult = try await AuthService.shared.getAuthenticatedUser()
            try await collection.removeUserFavoriteBook(userId: authDataResult.uid, favoriteBookID: bookID)
        } catch {
            Logger.shared.log("Couldn't remove from \(collection.displayName) collection")
        }
    }

}
