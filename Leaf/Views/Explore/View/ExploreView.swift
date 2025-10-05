//
//  SearchView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var selectedSubject = ""
    @State private var bookSectionTitle = "Popular"

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                // MARK: - Search Field
                searchField
                    .padding(.horizontal)
                    .padding(.top, 12)

                // MARK: - Subjects Section
                subjectSection
                    .padding(.horizontal)

                Divider()

                // MARK: - Books Section
                booksSection
            }
            .navigationTitle("Leaf")
            .onAppear {
                Task { await viewModel.getBooksBySubject("fantasy") }
            }
        }
    }
}

#Preview {
    NavigationView {
        ExploreView()
    }
}

// MARK: - UI Components
extension ExploreView {
    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            TextField("Search by title or author", text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onChange(of: viewModel.searchText) { _, newValue in
                    bookSectionTitle = "Search for '\(viewModel.searchText)'"
                    Task { await viewModel.searchBook(newValue) }
                }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }

    private var subjectSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.subjects, id: \.self) { subject in
                    Text(subject.capitalized)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .foregroundStyle(selectedSubject == subject && viewModel.searchText.isEmpty ? .green : Color(.systemGray6))
                        )
                        .foregroundStyle(selectedSubject == subject && viewModel.searchText.isEmpty ? .white : .primary)
                        .onTapGesture {
                            viewModel.searchText = ""
                            bookSectionTitle = subject
                            withAnimation(.easeInOut) {
                                selectedSubject = subject
                            }
                            Task { await viewModel.getBooksBySubject(subject) }
                        }
                }
            }
            .padding(.vertical, 6)
        }
    }

    private var booksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(bookSectionTitle)
                .font(.headline)
                .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 120), spacing: 16)
                ], spacing: 20) {
                    ForEach(viewModel.books) { book in
                        NavigationLink(destination: BookDescriptionView(book: book)) {
                            BookCellView(book: book)
                                .contextMenu {
                                    Button("Add to favorites") {
                                        Task {
                                            await viewModel.addUserFavoriteBook(book)
                                        }
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
