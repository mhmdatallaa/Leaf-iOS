//
//  BookDescriptionViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 26/09/2025.
//

import Foundation

@MainActor
final class BookDescriptionViewModel: ObservableObject {
    @Published var alertMessage: String = ""
    
    func addToUserCollection(book: Book, collection: UserColletion) async {
        
        switch collection {
        case .favorites:
            do {
                try await handleUserCollection(book: book, collection: collection)
                alertMessage = "Added to favorites"
            } catch {
                alertMessage = "Can't add to favorites,try again!"
            }
        case .read:
            do {
                try await handleUserCollection(book: book, collection: collection)
                alertMessage = "Added to Read collection"
            } catch {
                alertMessage = "Can't add to Read collection,try again!"
            }
        case .wantToRead:
            do {
                try await handleUserCollection(book: book, collection: collection)
                alertMessage = "Added to Want to read collection"
            } catch {
                alertMessage = "Can't add to Want to read collection,try again!"
            }
        case .reading:
            do {
                try await handleUserCollection(book: book, collection: collection)
                alertMessage = "Added to Reading collection"
            } catch {
                alertMessage = "Can't add to Reading collection,try again!"
            }
        }
    }
    
    private func handleUserCollection(book: Book, collection: UserColletion) async throws {
        let user = try AuthManager.shared.getAuthenticatedUser()
        try collection.addUserFavoriteBook(userId: user.id, book: book)
    }
}
