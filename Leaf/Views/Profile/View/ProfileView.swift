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
    @State private var showSettingsView = false
    
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
//                    settingsList
                    
                    VStack(alignment: .leading, spacing: 20) {
                        BooksSection(sectionTitle: "Reading", books: viewModel.readingbooks, collection: .reading, profileViewModel: viewModel)
                            .environmentObject(viewModel)
                        BooksSection(sectionTitle: "Want to read", books: viewModel.wantToReadBooks, collection: .wantToRead, profileViewModel: viewModel)
                        BooksSection(sectionTitle: "Read", books: viewModel.readBooks, collection: .read, profileViewModel: viewModel)
                    }
                    .padding()
                                        
                    Spacer(minLength: 40)
                }

            }
            .sheet(isPresented: $showSettingsView, content: {
                logoutButton
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettingsView = true
                    } label: {
                        Image(systemName: "gear")
                            .fontWeight(.bold)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadUserCollection(collection: .reading)
                    await viewModel.loadUserCollection(collection: .wantToRead)
                    await viewModel.loadUserCollection(collection: .read)
                    await viewModel.loadUserCollection(collection: .favorites)
                }
            }
            .navigationTitle("My Profile")
            .task {
                await viewModel.loadCurrentUser()
            }
        }
    }
}



#Preview {
    ProfileView(showSignInView: .constant(false))
}

extension ProfileView {
    private var headerSection: some View {
        VStack(spacing: 12) {
//            Image(systemName: "person") // replace with AsyncImage for remote
//                .resizable()
//                .frame(width: 100, height: 100)
//                .scaledToFit()
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.green, lineWidth: 2))
            InitialImage(text: (viewModel.user?.firstName ?? "")  + " " + (viewModel.user?.lastName ?? "") )
            
            Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("\(viewModel.user?.email ?? "")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 32)
    }
    
    private var statsSection: some View {
        HStack(spacing: 40) {
            VStack {
                Text("\(viewModel.readBooks.count)")
                    .font(.headline)
                Text("Books")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            VStack {
                Text("\(viewModel.favoriteBooks.count)")
                    .font(.headline)
                Text("Favorites")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var logoutButton: some View {
        Form {
            Button("Logout") {
                Task {
                    await viewModel.logOut()
                    showSignInView = true
                }
            }
        }
    }
}
