//
//  FavoriteViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 25/09/2025.
//

import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {
    @Published var favoriteBooks: [Book] = []
    
    func getFavorites() async {
        var favoriteBooks: [Book] = []
        do {
            let authDataResult = try await AuthService.shared.getAuthenticatedUser()
           let UserFavoriteBooks =  try await UserManager.shared.getUserFavoriteBooks(userID: authDataResult.uid)
            
            Logger.shared.log("\(UserFavoriteBooks)")
            for UserFavoriteBook in UserFavoriteBooks {
                let book = Book(title: UserFavoriteBook.title, authors: [Author(key: "", name: UserFavoriteBook.authorName)], coverID: UserFavoriteBook.coverId, coverSize: nil, editionCount: nil, firstPublishYear: nil)
                favoriteBooks.append(book)
            }
            self.favoriteBooks = favoriteBooks
        } catch {
            Logger.shared.log("Can't fetch user favorite books")
        }
    }
    
    func removeFavoriteBook(name: String) async {
        do {
            let authDataResult = try await AuthService.shared.getAuthenticatedUser()
            try await UserManager.shared.removeUserFavoriteBook(userId: authDataResult.uid, favoriteBookID: name)
        } catch {
            Logger.shared.log("Can't remove book from favorites")
        }
    }
}
