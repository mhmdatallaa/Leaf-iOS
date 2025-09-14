//
//  BooksRepository.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import SwiftUI

protocol BooksRepository {
    func getBooks(by subject: String) async throws -> Subject
    func searchBooks(query: String) async throws -> [Book]
}

struct BooksRepositoryUseCase: BooksRepository {
    func getBooks(by subject: String) async throws -> Subject {
        let response: Subject = try await NetworkService.shared.request(OLBooksAPI.booksBySubject(suject: subject), as: Subject.self)
        
        return response
    }
    
    func searchBooks(query: String) async throws -> [Book] {
        let response: [Book] = try await NetworkService.shared.request(OLBooksAPI.search(query: query), as: [Book].self)
        return response
    }
}


