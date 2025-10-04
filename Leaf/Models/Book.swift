//
//  Book.swift
//  Leaf
//
//  Created by Mohamed Atallah on 21/09/2025.
//

import Foundation

struct Book: Identifiable, Decodable {
    var id = UUID().uuidString
    let title: String?
    let authors: [Author]?
    let coverID: Int?
    let coverSize: BookCoverSize?
    let editionCount: Int?
    let firstPublishYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case title, authors, coverSize
        case coverID = "cover_id"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
    }
}

enum BookCoverSize: String, Decodable {
    case small = "S"
    case medium = "M"
    case large = "L"
}


extension Book {
    static var sambleData: Book {
        Book(title: "Harry Poter", authors: [Author(key: "12818862", name: "J.K Rolling")], coverID: 12818862, coverSize: .medium, editionCount: 1223, firstPublishYear: 11111)
    }
}

struct Author: Decodable {
    let key, name: String?
}
