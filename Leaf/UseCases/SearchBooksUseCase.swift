//
//  SearchBooksUseCase.swift
//  Leaf
//
//  Created by Mohamed Atallah on 21/09/2025.
//

import Foundation

final class SearchBooksUseCase {
    private let repository: BooksRepository
    
    init(repository: BooksRepository = DefaultBooksRepository()) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> Search {
        try await repository.searchBooks(query: query)
    }
}
