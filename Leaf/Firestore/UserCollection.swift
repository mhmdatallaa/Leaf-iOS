//
//  UserCollection.swift
//  Leaf
//
//  Created by Mohamed Atallah on 27/09/2025.
//

import Foundation

enum UserColletion: UserFireStoreCollction {
    case favorites, read, wantToRead, reading
    
    var collectionName: String {
        switch self {
        case .favorites: "favorite_books"
        case .read: "read_books"
        case .wantToRead: "want_to_read_books"
        case .reading: "reading_books"
        }
    }
}

extension UserColletion: CaseIterable {
    var displayName: String {
            switch self {
            case .favorites: "Add to Favorites"
            case .reading: "Reading"
            case .read: "Read"
            case .wantToRead: "Want to Read"
            }
        }
}
