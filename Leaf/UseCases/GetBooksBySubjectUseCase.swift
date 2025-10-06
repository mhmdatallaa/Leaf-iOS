//
//  GetBooksBySubjectUseCase.swift
//  Leaf
//
//  Created by Mohamed Atallah on 21/09/2025.
//

import Foundation

final class GetBooksBySubjectUseCase {
    private let repository: BooksRepository
    
    init(repository: BooksRepository = DefaultBooksRepository()) {
        self.repository = repository
    }
    
    func execute(subject: String) async throws -> Subject {
        try await repository.getBooks(by: subject)
    }
}
