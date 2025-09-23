//
//  UserManager.swift
//  Leaf
//
//  Created by Mohamed Atallah on 23/09/2025.
//

import Foundation
import FirebaseFirestore

class UserManager {
    static let shared = UserManager()
    private init() { }
    
    func createUser(auth: AuthDataResult) async throws {
        var data: [String: Any] = [
            "user_id" : auth.uid,
            "date_created": Timestamp(),
        ]
        if let firstName = auth.firstName {
            data["first_name"] = firstName

        }
        if let lastName = auth.lastName {
            data["last_name"] = lastName

        }
        if let email = auth.email {
            data["email"] = email

        }
        if let photoURL = auth.photoURL {
            data["photo_url"] = photoURL

        }
        try await Firestore.firestore().collection("users").document(auth.uid).setData(data, merge: false)
    }
    
    func getUser(userId: String) async throws ->  DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        let firstName = data["first_name"] as? String
        let lastName = data["last_name"] as? String
        let email = data["email"] as? String
        let photoURL = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(id: userId, firstName: firstName, lastName: lastName, email: email, dateCreated: dateCreated)
    }
}
