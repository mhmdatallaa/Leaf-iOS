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
    let numFound, start: Int?
    let numFoundExact: Bool?
    let searchNumFound: Int?
    let documentationURL: String?
    let q: String?
    let docs: [Doc]?

    enum CodingKeys: String, CodingKey {
        case numFound, start, numFoundExact
        case searchNumFound = "num_found"
        case documentationURL = "documentation_url"
        case q, docs
    }
}

// MARK: - Doc
struct Doc: Codable {
    let authorKey, authorName: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let editionCount, firstPublishYear: Int?
    let hasFulltext: Bool?
    let ia: [String]?
    let iaCollectionS, key: String?
    let language: [String]?
    let lendingEditionS, lendingIdentifierS: String?
    let publicScanB: Bool?
    let title: String?
    let idStandardEbooks, idProjectGutenberg, idLibrivox: [String]?
    let subtitle: String?
    let idWikisource: [String]?

    enum CodingKeys: String, CodingKey {
        case authorKey = "author_key"
        case authorName = "author_name"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case ia
        case iaCollectionS = "ia_collection_s"
        case key, language
        case lendingEditionS = "lending_edition_s"
        case lendingIdentifierS = "lending_identifier_s"
        case publicScanB = "public_scan_b"
        case title
        case idStandardEbooks = "id_standard_ebooks"
        case idProjectGutenberg = "id_project_gutenberg"
        case idLibrivox = "id_librivox"
        case subtitle
        case idWikisource = "id_wikisource"
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
