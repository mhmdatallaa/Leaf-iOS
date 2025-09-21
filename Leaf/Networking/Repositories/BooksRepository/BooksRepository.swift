//
//  BooksRepository.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import SwiftUI

protocol BooksRepository {
    func getBooks(by subject: String) async throws -> Subject
    func searchBooks(query: String) async throws -> Search
}

struct DefaultBooksRepository: BooksRepository {
    func getBooks(by subject: String) async throws -> Subject {
        let response: Subject = try await NetworkService.shared.request(OLBooksAPI.booksBySubject(suject: subject), as: Subject.self)
        
        return response
    }
    
    func searchBooks(query: String) async throws -> Search {
        let response: Search = try await NetworkService.shared.request(OLBooksAPI.search(query: query), as: Search.self)
        return response
    }
}


