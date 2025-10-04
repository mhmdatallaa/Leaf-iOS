//
//  AuthenticationEngine.swift
//  Leaf
//
//  Created by Mohamed Atallah on 04/10/2025.
//

import Foundation


protocol AuthEngine {
    func getAuthenticatedUser() throws -> LeafUser
    func createUser(email: String, password: String) async throws -> LeafUser
    func signInUser(email: String, password: String) async throws -> LeafUser
    func resetPassword(email: String) async throws
    func updatePassword(password: String) async throws
    func updateEmail(email: String) async throws
    func signOut() throws
}
