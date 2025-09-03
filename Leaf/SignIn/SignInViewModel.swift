//
//  SignInViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import Foundation



@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var showError: Bool = false
    
    // Validation states
    @Published var isEmailValid = false
    @Published var showEmailError = false
    @Published var isPasswordValid = false
    @Published var showPasswordError = false
    
    
    func signIn() async -> Bool {
        
        do {
            try await AuthService.shared.signInUser(email: email, password: password)
            Logger.shared.log("User signed in successfully")
            return true
        } catch  {
            self.error = error.localizedDescription
            showError = true
            Logger.shared.log("\(error)", level: .error)
        }
        return false
    }
    
    func validateEmail() {
        let isEmpty = email.isEmpty
        let isValid = email.isValidEmail()
        isEmailValid = !isEmpty && isValid
        // For error display: only show error if not empty but invalid
        showEmailError = !isEmpty && !isValid
    }
    
    func validatePassword() {
            isPasswordValid = password.isValidPassword()
            showPasswordError = !password.isValidPassword()
    }
}
