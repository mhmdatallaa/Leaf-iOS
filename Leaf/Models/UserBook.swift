//
//  UserFavoriteBook.swift
//  Leaf
//
//  Created by Mohamed Atallah on 25/09/2025.
//

import Foundation

struct UserBook: Codable, Identifiable {
    let id: String
    let title: String?
    let authorName: String?
    let coverId: Int?
    let dateCreated: Date
    init(id: String, title: String?, authorName: String?, coverId: Int?) {
        self.id = id
        self.title = title
        self.authorName = authorName
        self.coverId = coverId
        self.dateCreated = Date()
    }
    
    var toBook: Book {
        Book(title: title, authors: [Author(key: nil, name: authorName)], coverID: coverId, coverSize: nil, editionCount: nil, firstPublishYear: nil)
    }
}
