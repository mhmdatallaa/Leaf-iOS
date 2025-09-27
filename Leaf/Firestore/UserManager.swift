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




// Favorite books
//struct UserFavoriteBookColletion: UserFireStoreCollction {
//    var collectionName: String = "favorite_books"
//}


//
//// Favorite books section
//extension UserManager {
//    private func userFavoriteBookCollection(userID: String) -> CollectionReference {
//        userDocument(userId: userID).collection("favorite_books")
//    }
//    
//    private func userFavoriteBookDocument(userId: String, favoriteBookID: String) -> DocumentReference {
//        userFavoriteBookCollection(userID: userId).document(favoriteBookID)
//    }
//    
//    func addUserFavoriteBook(userId: String, book: Book) throws {
//        let document = userFavoriteBookCollection(userID: userId).document(book.title!)
//        let documentId = document.documentID
//        let userFavoriteBook = UserBook(id: documentId, title: book.title, authorName: book.authors?.first?.name, coverId: book.coverID)
//        try document.setData(from: userFavoriteBook, merge: false, encoder: encoder)
//    }
//    
//    func removeUserFavoriteBook(userId: String, favoriteBookID: String) async throws {
//        try await userFavoriteBookDocument(userId: userId, favoriteBookID: favoriteBookID).delete()
//    }
//    
//    func getUserFavoriteBooks(userID: String) async throws -> [UserBook] {
//        let snapshot = try await userFavoriteBookCollection(userID: userID).getDocuments()
//
//        let result = try snapshot.documents.compactMap { document in
//            try document.data(as: UserBook.self, decoder: decoder)
//        }
//        return result
//    }
//}
//
//
//// READ books section
//extension UserManager {
//    private func userReadBookCollection(userID: String) -> CollectionReference {
//        userDocument(userId: userID).collection("read_books")
//    }
//    
//    private func userReadBookDocument(userId: String, favoriteBookID: String) -> DocumentReference {
//        userFavoriteBookCollection(userID: userId).document(favoriteBookID)
//    }
//    
//    func addUserReadBook(userId: String, book: Book) throws {
//        let document = userFavoriteBookCollection(userID: userId).document(book.title!)
//        let documentId = document.documentID
//        let userFavoriteBook = UserBook(id: documentId, title: book.title, authorName: book.authors?.first?.name, coverId: book.coverID)
//        try document.setData(from: userFavoriteBook, merge: false, encoder: encoder)
//    }
//    
//    func removeUserReadBook(userId: String, favoriteBookID: String) async throws {
//        try await userFavoriteBookDocument(userId: userId, favoriteBookID: favoriteBookID).delete()
//    }
//    
//    func getUserReadBooks(userID: String) async throws -> [UserBook] {
//        let snapshot = try await userFavoriteBookCollection(userID: userID).getDocuments()
//
//        let result = try snapshot.documents.compactMap { document in
//            try document.data(as: UserBook.self, decoder: decoder)
//        }
//        return result
//    }
//}
//
//// Reading books section
//extension UserManager {
//    private func userReadingBookCollection(userID: String) -> CollectionReference {
//        userDocument(userId: userID).collection("reading_books")
//    }
//    
//    private func userReadingBookDocument(userId: String, favoriteBookID: String) -> DocumentReference {
//        userFavoriteBookCollection(userID: userId).document(favoriteBookID)
//    }
//    
//    func addUserReadingBook(userId: String, book: Book) throws {
//        let document = userFavoriteBookCollection(userID: userId).document(book.title!)
//        let documentId = document.documentID
//        let userFavoriteBook = UserBook(id: documentId, title: book.title, authorName: book.authors?.first?.name, coverId: book.coverID)
//        try document.setData(from: userFavoriteBook, merge: false, encoder: encoder)
//    }
//    
//    func removeUserReadingBook(userId: String, favoriteBookID: String) async throws {
//        try await userFavoriteBookDocument(userId: userId, favoriteBookID: favoriteBookID).delete()
//    }
//    
//    func getUserReadingBooks(userID: String) async throws -> [UserBook] {
//        let snapshot = try await userFavoriteBookCollection(userID: userID).getDocuments()
//
//        let result = try snapshot.documents.compactMap { document in
//            try document.data(as: UserBook.self, decoder: decoder)
//        }
//        return result
//    }
//}
//
//// Reading books section
//extension UserManager {
//    private func userWantToReadBookCollection(userID: String) -> CollectionReference {
//        userDocument(userId: userID).collection("want_reading_books")
//    }
//    
//    private func userWantToReadBookDocument(userId: String, favoriteBookID: String) -> DocumentReference {
//        userFavoriteBookCollection(userID: userId).document(favoriteBookID)
//    }
//    
//    func addUserWantToReadBook(userId: String, book: Book) throws {
//        let document = userFavoriteBookCollection(userID: userId).document(book.title!)
//        let documentId = document.documentID
//        let userFavoriteBook = UserBook(id: documentId, title: book.title, authorName: book.authors?.first?.name, coverId: book.coverID)
//        try document.setData(from: userFavoriteBook, merge: false, encoder: encoder)
//    }
//    
//    func removeUserWantToReadBook(userId: String, favoriteBookID: String) async throws {
//        try await userFavoriteBookDocument(userId: userId, favoriteBookID: favoriteBookID).delete()
//    }
//    
//    func getUserWantToReadBooks(userID: String) async throws -> [UserBook] {
//        let snapshot = try await userFavoriteBookCollection(userID: userID).getDocuments()
//
//        let result = try snapshot.documents.compactMap { document in
//            try document.data(as: UserBook.self, decoder: decoder)
//        }
//        return result
//    }
//}
