//
//  UserCollectionView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 05/10/2025.
//

import SwiftUI

struct UserCollectionView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let collection: UserColletion
    var books: [UserBook]
    var body: some View {
        NavigationView {
            List(books) { book in
                FavoriteBookCell(book: book.toBook)
                        .contextMenu {
                            Button("Remove from \(collection.displayName)") {
                                Task {
                                    await viewModel.removeBookFromCollection(collection: collection, bookID: book.toBook.title ?? "")
                                    await viewModel.loadUserCollection(collection: collection)
                                }
                            }
                        }
            }
            .navigationTitle(collection.displayName)
            .onAppear {
                Task {
                    await viewModel.loadUserCollection(collection: collection)
                }
            }
        }
    }
}

#Preview {
    UserCollectionView(viewModel: ProfileViewModel(), collection: .wantToRead, books: [])
}
