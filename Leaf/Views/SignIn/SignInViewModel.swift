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
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isLoading: Bool = false
    
    // Validation states
    @Published var isEmailValid: Bool = false
    @Published var showEmailError: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var showPasswordError: Bool = false
    
    
    func signIn() async -> Bool {
        
        do {
            isLoading = true
            try await AuthService.shared.signInUser(email: email, password: password)
            isLoading = false
            Logger.shared.log("User signed in successfully")
            return true
        } catch  {
            self.alertMessage = error.localizedDescription
            showAlert = true
            isLoading = false
            Logger.shared.log("\(error)", level: .error)
        }
        return false
    }
    
    func forgetPassword(for email: String) async {
        do {
            isLoading = true
            try await  AuthService.shared.resetPassword(email: email)
            isLoading = false
            showAlert = true
            alertMessage = "An email has been sent, check out your inbox."
            Logger.shared.log("User is reseting password")
        } catch {
            // handle error
            Logger.shared.log("Error reseting password")
            isLoading = false
            showAlert = true
            alertMessage = error.localizedDescription

        }
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
