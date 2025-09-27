//
//  FavoriteView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 25/09/2025.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.favoriteBooks) { book in
                    FavoriteBookCell(book: book)
                        .contextMenu {
                            Button("Remove from favorite") {
                                Task {
                                    await viewModel.removeFavoriteBook(name: book.title!)
                                    await viewModel.getFavorites()
                                }
                            }
                        }
            }
            .navigationTitle("Favorites")
            .onAppear {
                Task {
                    await viewModel.getFavorites()
                }
            }
        }
    }
}

#Preview {
    RootView()
}
