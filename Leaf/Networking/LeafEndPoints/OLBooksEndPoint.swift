//
//  BooksAPI.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

// Endpoint for subject: https://openlibrary.org/subjects/love.json

import Foundation

enum OLBooksEndPoint: Endpoint {

    case search(query: String)
    case booksBySubject(suject: String)
    
    var baseURL: String { "https://openlibrary.org" }
    var path: String {
        switch self {
        case .search: "/search.json"
        case .booksBySubject(let subject): "/subjects/\(subject).json"
        }
    }
    var method: HTTPMethod { .get }
    var headers: [String : String]? { nil }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let query): [URLQueryItem(name: "q", value: query)]
        case .booksBySubject : nil
        }
    }
    var body: Data? { nil }
}
