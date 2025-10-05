//
//  FavoriteViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 25/09/2025.
//

import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    let userFavoriteBookCollection: UserColletion = UserColletion.favorites
    
    func getFavorites() async {
        var favoriteBooks: [Book] = []
        do {
            let user = try AuthManager.shared.getAuthenticatedUser()
            let UserFavoriteBooks =  try await userFavoriteBookCollection.getUserFavoriteBooks(userID: user.id)
            
            Logger.shared.log("\(UserFavoriteBooks)")
            for UserFavoriteBook in UserFavoriteBooks {
                let book = Book(title: UserFavoriteBook.title, authors: [Author(key: "", name: UserFavoriteBook.authorName)], coverID: UserFavoriteBook.coverId, coverSize: nil, editionCount: nil, firstPublishYear: nil)
                favoriteBooks.append(book)
            }
            self.books = favoriteBooks
        } catch {
            Logger.shared.log("Can't fetch user favorite books")
        }
    }
    
    func removeFavoriteBook(name: String) async {
        do {
            let user = try AuthManager.shared.getAuthenticatedUser()
            try await userFavoriteBookCollection.removeUserFavoriteBook(userId: user.id, favoriteBookID: name)
        } catch {
            Logger.shared.log("Can't remove book from favorites")
        }
    }
}
