//
//  UserManager.swift
//  Leaf
//
//  Created by Mohamed Atallah on 23/09/2025.
//

import Foundation
import FirebaseFirestore

final class UserManager {
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("users")
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createUser(user: DBUser) throws {
        try userDocument(userId: user.id).setData(from: user, merge: false, encoder: encoder)
    }
    
    func getUser(userId: String) async throws ->  DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }

}

// Favorite books section
extension UserManager {
    private func userFavoriteBookCollection(userID: String) -> CollectionReference {
        userDocument(userId: userID).collection("favorite_books")
    }
    
    private func userFavoriteBookDocument(userId: String, favoriteBookID: String) -> DocumentReference {
        userFavoriteBookCollection(userID: userId).document(favoriteBookID)
    }
    
    func addUserFavoriteBook(userId: String, book: Book) throws {
        let document = userFavoriteBookCollection(userID: userId).document(book.title!)
        let documentId = document.documentID
        let userFavoriteBook = UserFavoriteBook(id: documentId, title: book.title, authorName: book.authors?.first?.name, coverId: book.coverID)
        try document.setData(from: userFavoriteBook, merge: false, encoder: encoder)
    }
    
    func removeUserFavoriteBook(userId: String, favoriteBookID: String) async throws {
        try await userFavoriteBookDocument(userId: userId, favoriteBookID: favoriteBookID).delete()
    }
    
    func getUserFavoriteBooks(userID: String) async throws -> [UserFavoriteBook] {
        let snapshot = try await userFavoriteBookCollection(userID: userID).getDocuments()

        let result = try snapshot.documents.compactMap { document in
            try document.data(as: UserFavoriteBook.self, decoder: decoder)
        }
        return result
    }
}


