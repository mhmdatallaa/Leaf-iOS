//
//  FetchBookCoverUseCase.swift
//  Leaf
//
//  Created by Mohamed Atallah on 21/09/2025.
//

import SwiftUI

final class FetchBookCoverUseCase {
    private let repository: BookCoverRepository
    private let leafCache = LeafCache<Int, UIImage>()
    
    
    init(repository: BookCoverRepository = DefaultBookCoverRepository()) {
        self.repository = repository
    }
    
    func execute(for book: Book) async throws -> UIImage {
        if let id = book.coverID, let cached = leafCache.value(forKey: id) {
            Logger.shared.log("From cache")
            return cached
        }
        let image = try await repository.fetchCover(for: book)
        if let id = book.coverID {
            leafCache.insert(value: image, forKey: id)
        }
        Logger.shared.log("Image downloading")
        return image
    }
}
