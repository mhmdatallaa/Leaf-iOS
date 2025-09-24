//
//  Search.swift
//  Leaf
//
//  Created by Mohamed Atallah on 15/09/2025.
//

import Foundation

import Foundation

// MARK: - Search
struct Search: Codable {
    let docs: [Doc]?

    enum CodingKeys: String, CodingKey {
        case docs
    }
}

// MARK: - Doc
struct Doc: Codable {
    let authorKey, authorName: [String]?
    let coverI: Int?
    let editionCount, firstPublishYear: Int?
    let hasFulltext: Bool?
    let title: String?
    let subtitle: String?

    enum CodingKeys: String, CodingKey {
        case authorKey = "author_key"
        case authorName = "author_name"
        case coverI = "cover_i"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case title
        case subtitle
    }
}


extension Search {
    var toBooks: [Book] {
        var books: [Book] = []
        guard let docs else { return [] }
        for book in docs {
            let book = Book(title: book.title, authors: [Author(key: book.authorKey?.first, name: book.authorName?.first)], coverID: book.coverI, coverSize: nil, editionCount: book.editionCount, firstPublishYear: book.firstPublishYear)
            books.append(book)
        }
        
        return books
    }
}
