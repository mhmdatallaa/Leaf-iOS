//
//  DBUser.swift
//  Leaf
//
//  Created by Mohamed Atallah on 23/09/2025.
//

import Foundation

struct DBUser: Codable {
    let id: String
    let firstName: String?
    let lastName: String?
    let email: String?
    let photoURL: String?
    let dateCreated: Date?
}

extension DBUser {
    init(firstName: String, lastName: String, authUser: LeafUser) {
        self.id = authUser.id
        self.firstName = firstName
        self.lastName = lastName
        self.email = authUser.email
        self.dateCreated = Date()
        self.photoURL = authUser.photoURL
    }
}
