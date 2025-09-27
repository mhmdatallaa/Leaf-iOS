//
//  UserFirestoreCollection.swift
//  Leaf
//
//  Created by Mohamed Atallah on 27/09/2025.
//

import Foundation
import FirebaseFirestore

protocol UserFireStoreCollction {
    
    var collectionName: String { get }
    
    func userFavoriteBookCollection(userID: String) -> CollectionReference
    func userFavoriteBookDocument(userId: String, favoriteBookID: String) -> DocumentReference
    func addUserFavoriteBook(userId: String, book: Book) throws
    func removeUserFavoriteBook(userId: String, favoriteBookID: String) async throws
    func getUserFavoriteBooks(userID: String) async throws -> [UserBook]
}

extension UserFireStoreCollction {

    var encoder: Firestore.Encoder {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    var decoder: Firestore.Decoder {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func userFavoriteBookCollection(userID: String) -> CollectionReference {
        let userCollection = Firestore.firestore().collection("users")
        return userCollection.document(userID).collection(collectionName)
    }
    
    func userFavoriteBookDocument(userId: String, favoriteBookID: String) -> DocumentReference {
        userFavoriteBookCollection(userID: userId).document(favoriteBookID)
    }
    
    func addUserFavoriteBook(userId: String, book: Book) throws {
        let document = userFavoriteBookCollection(userID: userId).document(book.title!)
        let documentId = document.documentID
        let userFavoriteBook = UserBook(id: documentId, title: book.title, authorName: book.authors?.first?.name, coverId: book.coverID)
        try document.setData(from: userFavoriteBook, merge: false, encoder: encoder)
    }
    
    func removeUserFavoriteBook(userId: String, favoriteBookID: String) async throws {
        try await userFavoriteBookDocument(userId: userId, favoriteBookID: favoriteBookID).delete()
    }
    
    func getUserFavoriteBooks(userID: String) async throws -> [UserBook] {
        let snapshot = try await userFavoriteBookCollection(userID: userID).getDocuments()

        let result = try snapshot.documents.compactMap { document in
            try document.data(as: UserBook.self, decoder: decoder)
        }
        return result
    }
}
