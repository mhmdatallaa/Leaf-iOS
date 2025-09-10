//
//  SignInView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showSignUpView: Bool = false
    @State private var showAlert: Bool = false
    @Binding var showSignInView: Bool
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Title
            welcomeTitle
            
            // Email
            emailField
            
            // Password
            passwordField
            
            // Sign In button
            signInButton
            
            // Forgot password
            forgetPasswordButton
            
            // Divider
            divider
            
            // Google Sign In
            googleSignInButton
            
            Spacer()
            
            // Join now
            joinNowButton
        }
        .padding(.horizontal, 30)
        .fullScreenCover(isPresented: $showSignUpView) {
            SignUpView()
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {
                viewModel.error = ""
            }
        } message: {
            Text(viewModel.error)
        }
        .onDisappear {
            Logger.shared.log("\(#file) view disappeared")
        }
    }
}

#Preview {
    SignInView(showSignInView: .constant(true))
}

    extension SignInView {
        private var welcomeTitle: some View {
            VStack(spacing: 8) {
                Text("Welcome Back,")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Sign in to continue")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 60)
            .padding(.bottom, 40)
        }
        
        private var emailField: some View {
            VStack(alignment: .leading, spacing: 4) {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .onChange(of: viewModel.email) { viewModel.validateEmail() }
                if viewModel.showEmailError {
                    Text("Please enter a valid email address")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 4)
                }
            }
        }
        
        private var passwordField: some View {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $viewModel.password)
                    } else {
                        SecureField("Password", text: $viewModel.password)
                    }
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .onChange(of: viewModel.password) { viewModel.validatePassword() }
                if viewModel.showPasswordError {
                    Text("Password must not be less that 8 characters long")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 4)
                }
            }
        }
        
        private var signInButton: some View {
            Button(action: {
                    Task {
                        if await viewModel.signIn() {
                            showSignInView = false
                        }
                    }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(25)
                } else {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            !viewModel.isEmailValid || !viewModel.isPasswordValid ?
                            Color.gray : Color.green
                        )
                        .cornerRadius(25)
                        .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
                }
            }
            .disabled(!viewModel.isEmailValid || !viewModel.isPasswordValid)
            .padding(.top, 10)
        }
        
        private var forgetPasswordButton: some View {
            Button(action: {
                // handle forgot password
            }) {
                Text("Forgot Password?")
                    .foregroundColor(.gray)
            }
        }
        
        private var divider: some View {
            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                Text("Or")
                    .foregroundColor(.gray)
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
            }
            .padding(.vertical, 8)
        }
        
        private var googleSignInButton: some View {
            Button(action: {
                // handle google login
            }) {
                HStack {
                    Image("google")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Sign In with Google")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            }
        }
        
        private var joinNowButton: some View {
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.gray)
                Button(action: {
                    showSignUpView = true
//                    dismiss()
                }) {
                    Text("Join Now")
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom, 40)
        }

    
}
