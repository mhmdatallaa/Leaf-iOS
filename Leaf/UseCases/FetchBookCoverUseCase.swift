//
//  FetchBookCoverUseCase.swift
//  Leaf
//
//  Created by Mohamed Atallah on 21/09/2025.
//

import SwiftUI

struct FetchBookCoverUseCase {
    private let repository: BookCoverRepository
    
    init(repository: BookCoverRepository = DefaultBookCoverRepository()) {
        self.repository = repository
    }
    
    func execute(for book: Book) async throws -> UIImage {
        try await repository.fetchCover(for: book)
    }
}
