//
//  Authentication.swift
//  Leaf
//
//  Created by Mohamed Atallah on 03/09/2025.
//

import Foundation

class AuthManager {
    private var engine: AuthEngine?
    static let shared = AuthManager()
    
    private init() { }
    
    func configure(engine: AuthEngine) {
        self.engine = engine
    }
    
    

    func getAuthenticatedUser() throws -> LeafUser {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.NotAuthenticated
        }
        return try engine.getAuthenticatedUser()
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> LeafUser {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.EmptyEmailOrPassword
        }
        return try await engine.createUser(email: email, password: password)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> LeafUser {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.EmptyEmailOrPassword
        }
        return try await engine.signInUser(email: email, password: password)
    }
    
    func resetPassword(email: String) async throws {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.EmptyEmailOrPassword
        }
        try await engine.resetPassword(email: email)
    }
    
    func updatePassword(password: String) async throws {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.EmptyEmailOrPassword
        }
        try await engine.updatePassword(password: password)
    }
    
    func updateEmail(email: String) async throws {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.EmptyEmailOrPassword
        }
       try await engine.updateEmail(email: email)
    }
    
    func signOut() throws {
        guard let engine else {
            Logger.shared.log("Auth engine not configured")
            throw AuthError.EmptyEmailOrPassword
        }
        try engine.signOut()
    }
}


