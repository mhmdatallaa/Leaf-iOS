//
//  FavoriteBookCell.swift
//  Leaf
//
//  Created by Mohamed Atallah on 25/09/2025.
//

import SwiftUI

struct FavoriteBookCell: View {
    var book: Book
    @StateObject private var coverViewModel = CoverViewModel()
    
    var body: some View {
        HStack(spacing: 12) {
            // Book Cover
            //            ZStack {
            if coverViewModel.isLoading {
                ProgressView()
                    .frame(width: 100, height: 140)
            } else if let image = coverViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 90)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 2)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 90)
                    .overlay(
                        Image(systemName: "book")
                            .font(.title2)
                            .foregroundColor(.gray)
                    )
                    .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(book.title ?? "Untitled")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("by \(book.authors?.first?.name ?? "Unknown")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
            
            // Book Info
            
//        }
        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .task {
            await coverViewModel.getCover(for: book)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    FavoriteBookCell(book: Book.sambleData)
        .padding()
}
