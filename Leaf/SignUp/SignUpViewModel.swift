//
//  SignUpViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import Foundation

@MainActor
class SignUpViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    
    // Validation states
    @Published var isFirstNameValid: Bool = false
    @Published var showFirstNameError: Bool = false
    @Published var isLastNameValid: Bool = false
    @Published var showLastNameError: Bool = false
    @Published var isEmailValid: Bool = false
    @Published var showEmailError: Bool = false
    @Published var isPasswordValid: Bool =  false
    @Published var showPasswordError: Bool = false
    
    func signUp() async {
        do {
            isLoading = true
            try await AuthService.shared.createUser(email: email, password: password)
            isLoading = false
            Logger.shared.log("User signed-up successfully")
        } catch {
            self.error = error.localizedDescription
            showError = true
            isLoading = false
            Logger.shared.log("\(error)", level: .error)
        }
    }
    
    func validatFirstName() {
        isFirstNameValid = firstName.count > 2
        showFirstNameError = !(firstName.count > 2)
    }
    
    func validateLastName() {
        isLastNameValid = lastName.count > 2
        showLastNameError = !(lastName.count > 2)
    }
    
    func validateEmail() {
        let isEmpty = email.isEmpty
        let isValid = email.isValidEmail()
        isEmailValid = !isEmpty && isValid
        showEmailError = !isEmpty && !isValid
    }
    
    func validatePassword() {
        isPasswordValid = password.isValidPassword()
        showPasswordError = !password.isValidPassword()
    }
    
}
