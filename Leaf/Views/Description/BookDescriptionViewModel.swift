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
    func addUserFavoriteBook(_ book: Book) async {
        do {
            let authDataResult = try await AuthService.shared.getAuthenticatedUser()
            try UserManager.shared.addUserFavoriteBook(userId: authDataResult.uid, book: book)
            Logger.shared.log("\((book.title) ?? "Untitled") added to favorite")
            alertMessage = "Added to favorites"
        } catch {
            Logger.shared.log("Can't add user favorite book", level: .error)
            alertMessage = "Can't add to favorites,try again!"

        }
    }
}
