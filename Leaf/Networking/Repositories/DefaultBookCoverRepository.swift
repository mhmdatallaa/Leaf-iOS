//
//  ImageRepository.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import SwiftUI

protocol BookCoverRepository {
    func fetchCover(for book: Book) async throws -> UIImage
}

struct DefaultBookCoverRepository: BookCoverRepository {
    func fetchCover(for book: Book) async throws -> UIImage {
        let response: Data = try await NetworkService.shared.requestData(OLCoversEndPoint.bookCover(id: book.coverID ?? 0, size: book.coverSize ?? .medium))
        guard let image = UIImage(data: response) else {
            throw APIError.decodingFailed
        }
        return image
    }
}
