//
//  Subject.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import Foundation
struct Subject: Decodable {
    let name: String?
    let works: [Book]
    
    enum CodingKeys: String, CodingKey {
        case name, works
    }
}

enum BookCoverSize: String, Decodable {
    case small = "S"
    case medium = "M"
    case large = "L"
}

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

extension Book {
    static var sambleData: Book {
        Book(title: "Harry Poter", authors: [Author(key: "12818862", name: "J.K Rolling")], coverID: 12818862, coverSize: .medium, editionCount: 1223, firstPublishYear: 11111)
    }
}

struct Author: Decodable {
    let key, name: String?
}
