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
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(width: 120, height: 180)
                    .shadow(radius: 3, y: 2)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Image(systemName: "book.closed.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 70)
                        .foregroundColor(.secondary)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title ?? "Untitled")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(book.authors?.first?.name ?? "Unknown Author")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(width: 120, alignment: .leading)
        }
        .task {
            await viewModel.getCover(for: book)
        }
    }
}
#Preview(traits: .sizeThatFitsLayout) {
    BookCellView(book: Book.sambleData)
}
