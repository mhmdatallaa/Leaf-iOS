//
//  SearchViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import SwiftUI

@MainActor
class ExploreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var books: [Book] = []
    @Published var cover: UIImage?
    let subjects: [String] = [ "fiction", "fantasy", "romance", "history", "science", "biography", "self-help"]
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let getBooksBySubjectUseCase = GetBooksBySubjectUseCase()
    private let searchBooksUseCase = SearchBooksUseCase()
    
    private let userCollection: UserColletion = UserColletion.favorites
//    init(repository: BooksRepository = DefaultBooksRepository()) {
//        self.repository = repository
//    }
    func searchBook(_ text: String) async {
        do {
            isLoading = true
            let result = try await searchBooksUseCase.execute(query: text)
            let searchResult: Search = result
            self.books = searchResult.toBooks
        } catch {
            errorMessage = error.localizedDescription
            Logger.shared.log(error.localizedDescription, level: .error)
            Logger.shared.log("Books: \(books.count)")
        }
    }
    
    func getBooksBySubject(_ subject: String) async{
        do {
            isLoading = true
            let result = try await getBooksBySubjectUseCase.execute(subject: subject)
            self.books = result.works
            Logger.shared.log("Books: \(books.count)")
        } catch {
            errorMessage = error.localizedDescription
            Logger.shared.log(error.localizedDescription, level: .error)
        }
        isLoading = false
    }
    
    
    func addUserFavoriteBook(_ book: Book) async {
        do {
            let user = try  AuthManager.shared.getAuthenticatedUser()
            try userCollection.addUserFavoriteBook(userId: user.id, book: book)
            Logger.shared.log("\((book.title) ?? "Untitled") added to favorite")

        } catch {
            Logger.shared.log("Can't add user favorite book", level: .error)
        }
    }
    
}
