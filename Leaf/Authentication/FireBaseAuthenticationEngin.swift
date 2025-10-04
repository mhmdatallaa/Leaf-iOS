//
//  FireBaseAuthenticationEngin.swift
//  Leaf
//
//  Created by Mohamed Atallah on 04/10/2025.
//

import FirebaseAuth


class FireBaseAuthEngin: AuthEngine {
    func getAuthenticatedUser() throws -> LeafUser {
        guard let user = Auth.auth().currentUser else {
            Logger.shared.log("Can't get authenticated User", level: .error)
            throw AuthError.NotAuthenticated
        }
        return AuthDataResult(user: user).toLeafUser
    }
    
    func createUser(email: String, password: String) async throws -> LeafUser {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user).toLeafUser
    }
    
    func signInUser(email: String, password: String) async throws -> LeafUser {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResult(user: authDataResult.user).toLeafUser
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



struct AuthDataResult {
    let uid: String
    let name: String?
    var firstName: String? = nil
    var lastName: String? = nil
    var email: String?
    var photoURL: String? = nil
    
    init(user: User) {
        self.uid = user.uid
        self.name = user.displayName
        self.email = user.email
    }
    
    var toLeafUser: LeafUser {
        .init(
            id: uid,
            name: name,
            email: email,
            photoURL: photoURL
        )
    }
}
