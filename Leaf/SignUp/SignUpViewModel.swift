//
//  SignUpViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var showError: Bool = false
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthError.EmptyEmailOrPassword
        }
        try await AuthService.shared.createUser(email: email, password: password)
    }
}
