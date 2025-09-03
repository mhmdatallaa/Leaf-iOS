//
//  Authentication.swift
//  Leaf
//
//  Created by Mohamed Atallah on 03/09/2025.
//

import Foundation
import FirebaseAuth


 struct AuthDataResult {
    let uid: String
    let name: String?
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.name = user.displayName
        self.email = user.email
    }
}

actor AuthService {
    static let shared = AuthService()
    
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResult {
        guard let user = Auth.auth().currentUser else {
            Logger.shared.log("Can't get authenticated User", level: .error)
            throw AuthError.NotAuthenticated
        }
        return AuthDataResult(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResult {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            Logger.shared.log("Can't get authenticated User to update password", level: .error)
            throw AuthError.NotAuthenticated
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let user = Auth.auth().currentUser else {
            Logger.shared.log("Can't get authenticated User to update email", level: .error)
            throw AuthError.NotAuthenticated
        }
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
