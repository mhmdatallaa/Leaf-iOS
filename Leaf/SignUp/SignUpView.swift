//
//  SignUpView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var isPasswordVisible: Bool = false
    @State private var showSignInView: Bool = false
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                // MARK: - Title
                welcomeTitle
                
                // MARK: - First Name
                firstNameField
                
                // MARK: - Last Name
                lastNameField
                
                // MARK: - Email
                emailField
                
                // MARK: - Password
                passwordField
                
                // MARK: - Sign Up Button
                signUpButton
                    .padding(.top, 12)
                
                // MARK: - Already have account
                signInButton
                
                // MARK: - Divider
                divider
                
                // MARK: - Google
                googleSignUpButton
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 24)
            .padding(.top, 50)
        }
        .fullScreenCover(isPresented: $showSignInView) {
            SignInView(showSignInView: $showSignInView)
        }
        .alert("", isPresented: $viewModel.showAlert) {
            Button("Ok", role: .cancel) { viewModel.alertMessage = "" }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    SignUpView()
}



extension SignUpView {
    
    // MARK: - Title
    private var welcomeTitle: some View {
        VStack(spacing: 6) {
            Text("Leaf")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(.green)
            
            Text("Create your account 🌱")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Join us to explore and read more")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .multilineTextAlignment(.center)
        .padding(.bottom, 20)
    }
    
    // MARK: - First Name
    private var firstNameField: some View {
        textFieldWithValidation(
            icon: "person",
            placeholder: "First name",
            text: $viewModel.firstName,
            error: viewModel.showFirstNameError ? "At least 2 characters" : nil
        ) {
            viewModel.validatFirstName()
        }
    }
    
    // MARK: - Last Name
    private var lastNameField: some View {
        textFieldWithValidation(
            icon: "person",
            placeholder: "Last name",
            text: $viewModel.lastName,
            error: viewModel.showLastNameError ? "At least 2 characters" : nil
        ) {
            viewModel.validateLastName()
        }
    }
    
    // MARK: - Email
    private var emailField: some View {
        textFieldWithValidation(
            icon: "envelope",
            placeholder: "Email",
            text: $viewModel.email,
            error: viewModel.showEmailError ? "Enter a valid email" : nil
        ) {
            viewModel.validateEmail()
        }
    }
    
    // MARK: - Password
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                if isPasswordVisible {
                    TextField("Password", text: $viewModel.password)
                } else {
                    SecureField("Password", text: $viewModel.password)
                }
                Button { isPasswordVisible.toggle() } label: {
                    Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .onChange(of: viewModel.password) { viewModel.validatePassword() }
            
            if viewModel.showPasswordError {
                Text("At least 8 characters")
                    .font(.caption2)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
            }
        }
    }
    
    // MARK: - Sign Up Button
    private var signUpButton: some View {
        Button {
            Task { await viewModel.signUp() }
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            } else {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isEmailValid && viewModel.isPasswordValid ? Color.green : Color.gray)
                    .cornerRadius(12)
                    .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
            }
        }
        .disabled(!viewModel.isEmailValid || !viewModel.isPasswordValid)
    }
    
    // MARK: - Divider
    private var divider: some View {
        HStack {
            Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
            Text("Or continue with")
                .font(.caption)
                .foregroundColor(.gray)
            Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
        }
        .padding(.vertical, 12)
    }
    
    // MARK: - Google Button
    private var googleSignUpButton: some View {
        Button(action: { /* handle Google */ }) {
            HStack {
                Image("google")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Google")
                    .foregroundColor(.black)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.15), radius: 5, x: 0, y: 2)
        }
    }
    
    // MARK: - Footer
    private var signInButton: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(.gray)
            Button { dismiss() } label: {
                Text("Sign In")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
            }
        }
        .font(.footnote)
        .padding(.bottom, 30)
    }
    
    // MARK: - Helper for TextFields
    private func textFieldWithValidation(icon: String, placeholder: String, text: Binding<String>, error: String?, onChange: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                TextField(placeholder, text: text)
                    .onChange(of: text.wrappedValue) { _ in onChange() }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            if let error = error {
                Text(error)
                    .font(.caption2)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
            }
        }
    }
}
