//
//  BookCellView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import SwiftUI

struct BookCellView: View {
    var book: Book
    @StateObject private var viewModel = CoverViewModel()
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .frame(width: 80, height: 100)
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 100)
                    .cornerRadius(8)
            } else {
                Image(systemName: "book.closed")
                    .resizable()
                    .frame(width: 50, height: 70)
            }
            Text(book.title ?? "N/A")
                .font(.callout)
            Text("by \(book.authors?.first?.name ?? "N/A")")
                .font(.caption)
            
        }
        .task {
            await viewModel.getCover(for: book)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookCellView(book: Book.sambleData)
}
