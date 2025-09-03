//
//  SignUpView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showSignInView: Bool = false
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Title
            welcomeTitle
            
            // FirstName
            firstNameField
            
            //LastName
            lastNameField
            
            // Email
            emailField
            
            // Password
            passwordField
            
            // Sign In button
            signUpButton
            
            // SignIn
            SignInButton
            
            // Divider
            divider
            
            // Google Sign UP
            googleSignUPButton
            
            Spacer()
            
            
        }
        .padding(.horizontal, 30)
        .fullScreenCover(isPresented: $showSignInView) {
            SignInView(showSignInView: $showSignInView)
        }
        .onDisappear {
            Logger.shared.log("\(#file) view disappeared")
        }
    }
}

#Preview {
    SignUpView()
}



extension SignUpView {
    private var welcomeTitle: some View {
        VStack(spacing: 8) {
            Text("Welcome,")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Sign Up to continue")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 40)
        //            .padding(.bottom, 30)
    }
    
    private var firstNameField: some View {
        TextField("FirstName", text: $firstName)
            .padding()
            .cornerRadius(25)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            }
    }
    
    private var lastNameField: some View {
        TextField("FirstName", text: $lastName)
            .padding()
            .cornerRadius(25)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            }
    }
    
    private var emailField: some View {
        TextField("Email", text: $viewModel.email)
            .keyboardType(.emailAddress)
            .padding()
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
    }
    
    private var passwordField: some View {
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
    }
    
    private var signUpButton: some View {
        Button(action: {
            Task {
                do {
                    try await viewModel.signUp()
                    Logger.shared.log("User created successfully")
                } catch {
                    Logger.shared.log("\(error.localizedDescription)", level: .error)
                }
            }
        }) {
            Text("Sign Up")
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(25)
                .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
        }
        .padding(.top, 10)
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
    
    private var googleSignUPButton: some View {
        Button(action: {
            // handle google login
        }) {
            HStack {
                Image("google")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("Sign Up with Google")
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
    
    private var SignInButton: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(.gray)
            Button(action: {
                dismiss()
            }) {
                Text("Sign In")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom, 20)
    }
    
    
}
