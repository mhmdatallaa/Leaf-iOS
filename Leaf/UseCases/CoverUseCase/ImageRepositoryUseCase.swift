//
//  ImageRepository.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import SwiftUI

protocol ImageRepository {
    func fetchCover(for book: Book) async throws -> UIImage
}

final class ImageRepositoryUseCase: ImageRepository {
    func fetchCover(for book: Book) async throws -> UIImage {
        let response: Data = try await NetworkService.shared.requestData(OLCoversAPI.bookCover(id: book.coverID ?? 0, size: book.coverSize ?? .medium))
        guard let image = UIImage(data: response) else {
            throw APIError.decodingFailed
        }
        return image
    }
}
