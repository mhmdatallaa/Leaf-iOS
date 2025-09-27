//
//  BooksSection.swift
//  Leaf
//
//  Created by Mohamed Atallah on 27/09/2025.
//

import SwiftUI

struct BooksSection: View {
    var sectionTitle: String
    var books: [UserBook]
    let collection: UserColletion
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var presentSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(sectionTitle)
                    .font(.headline)
                Spacer()
                if books.count > 6 {
                    Button("See all") {
                        presentSheet = true
                    }
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(books.prefix(5)) { book in
                        BookCell(book: book.toBook, collection: collection, profileViewModel: profileViewModel)
                    }
                }
            }
        }
        .sheet(isPresented: $presentSheet) {
            FavoriteView()
        }
    }
}

#Preview {
    BooksSection(sectionTitle: "Want to read",books: [], collection: .favorites, profileViewModel: ProfileViewModel())
}


struct BookCell: View {
    let book: Book
    let collection: UserColletion
    @StateObject private var viewModel = CoverViewModel()
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .contextMenu {
                        Button("Remove from collection") {
                            Task {
                                await profileViewModel.removeBookFromCollection(collection: collection, bookID: book.title ?? "")
                                await profileViewModel.loadUserCollection(collection: collection)
                            }
                        }
                    }
            } else {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 70)
                    .foregroundColor(.secondary)
            }
        }
        .task { await viewModel.getCover(for: book) }
    }
}
