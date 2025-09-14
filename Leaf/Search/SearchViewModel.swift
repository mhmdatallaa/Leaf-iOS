//
//  SearchViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var books: [Book] = []
    @Published var cover: UIImage?
    let subjects: [String] = [ "fiction", "fantasy", "romance", "history", "science", "biography", "self-help"]
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let repository: BooksRepository
    
    init(repository: BooksRepository = BooksRepositoryUseCase()) {
        self.repository = repository
    }
    
    func getBooksBySubject(_ subject: String) async{
        do {
            isLoading = true
            let result = try await repository.getBooks(by: subject)
            self.books = result.works
            Logger.shared.log("Books: \(books.count)")
            Logger.shared.log("love books \(result)")
        } catch {
            errorMessage = error.localizedDescription
            Logger.shared.log(error.localizedDescription, level: .error)
        }
        isLoading = false
    }
    
    
}
