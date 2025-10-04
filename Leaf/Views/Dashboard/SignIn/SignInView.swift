//
//  SignInView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI

struct SignInView: View {
    @State private var isPasswordVisible: Bool = false
    @State private var showSignUpView: Bool = false
    @State private var showForgetPasswordSheet = false
    @Binding var showSignInView: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                // MARK: - Title
                welcomeTitle
                
                // MARK: - Email
                emailField
                
                // MARK: - Password
                passwordField
                
                // MARK: - Forgot Password
                forgetPasswordButton
                
                // MARK: - Sign In
                signInButton
                    .padding(.top, 12)
                
                // MARK: - Divider
                divider
                
                // MARK: - Google Sign In
                googleSignInButton
                
                Spacer(minLength: 40)
                
                // MARK: - Join Now
                joinNowButton
            }
            .padding(.horizontal, 24)
            .padding(.top, 60)
        }
        .fullScreenCover(isPresented: $showSignUpView) {
            SignUpView()
        }
        .alert("", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { viewModel.alertMessage = "" }
        } message: {
            Text(viewModel.alertMessage)
        }
        .sheet(isPresented: $showForgetPasswordSheet) {
            resetPasswordSheet
        }
    }
}

#Preview {
    SignInView(showSignInView: .constant(true))
}

extension SignInView {
    
    // MARK: - Title
    private var welcomeTitle: some View {
        VStack(spacing: 6) {
            Text("Leaf")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(.green)
            Text("Welcome Back 👋")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Sign in to continue your journey")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .multilineTextAlignment(.center)
        .padding(.bottom, 20)
    }
    
    // MARK: - Email
    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(.gray)
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onChange(of: viewModel.email) { viewModel.validateEmail() }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        
        .overlay {
            if viewModel.showEmailError {
                Text("Enter a valid email")
                    .font(.caption2)
                    .foregroundColor(.red)
                    .padding(.top, 52)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    // MARK: - Password
    private var passwordField: some View {
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
        
        .overlay {
            if viewModel.showPasswordError {
                Text("At least 8 characters")
                    .font(.caption2)
                    .foregroundColor(.red)
                    .padding(.top, 52)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    // MARK: - Forgot Password
    private var forgetPasswordButton: some View {
        Button { showForgetPasswordSheet = true } label: {
            Text("Forgot Password?")
                .font(.footnote)
                .foregroundColor(.green)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    // MARK: - Sign In
    private var signInButton: some View {
        Button {
            Task {
                if await viewModel.signIn() { showSignInView = false }
            }
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            } else {
                Text("Sign In")
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
    private var googleSignInButton: some View {
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
    
    // MARK: - Reset Password Sheet
    private var resetPasswordSheet: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.headline)
            TextField("Enter your email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            Button("Reset") {
                Task {
                    await viewModel.forgetPassword(for: viewModel.email)
                    showForgetPasswordSheet = false
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    // MARK: - Footer
    private var joinNowButton: some View {
        HStack {
            Text("Don’t have an account?")
                .foregroundColor(.gray)
            Button { showSignUpView = true } label: {
                Text("Join Now")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
            }
        }
        .font(.footnote)
        .padding(.bottom, 30)
    }
}
