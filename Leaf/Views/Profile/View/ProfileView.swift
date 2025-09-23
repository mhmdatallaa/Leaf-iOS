//
//  ProfileView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 23/09/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // MARK: - Header
                    headerSection
                    
                    // MARK: - Stats
                    statsSection
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // MARK: - Settings List
                    settingsList
                    
                    // MARK: - Logout Button
                    logoutButton
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationTitle("Profile")
        }
    }
}



#Preview {
    ProfileView(showSignInView: .constant(false))
}

extension ProfileView {
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image("profile_placeholder") // replace with AsyncImage for remote
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.green, lineWidth: 2))
            
            Text("John Doe")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("john.doe@email.com")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 32)
    }
    
    private var statsSection: some View {
        HStack(spacing: 40) {
            VStack {
                Text("120")
                    .font(.headline)
                Text("Books")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            VStack {
                Text("45")
                    .font(.headline)
                Text("Favorites")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var settingsList: some View {
        VStack(spacing: 16) {
            ProfileRow(icon: "person.crop.circle", title: "Edit Profile")
            ProfileRow(icon: "heart", title: "Favorites")
            ProfileRow(icon: "book", title: "My Books")
            ProfileRow(icon: "gearshape", title: "Settings")
        }
        .padding(.horizontal)
    }
    
    private var logoutButton: some View {
        Button(action: {
            Task {
                await viewModel.logOut()
                showSignInView = true
            }
        }) {
            Text("Log Out")
                .foregroundColor(.red)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}
