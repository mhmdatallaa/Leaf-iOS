//
//  BookCellView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import SwiftUI

struct BookCellView: View {
    var body: some View {
        VStack {
            ZStack {
                Color.red
                    .frame(width: 60, height: 60)
                Image(systemName: "book.closed")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            Text("Harry Potter")
                .fontWeight(.bold)
            Text("by J.K Rolling")
                .font(.caption)
                
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BookCellView()
}
