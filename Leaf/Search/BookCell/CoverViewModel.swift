//
//  CoverViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import SwiftUI

@MainActor
final class CoverViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private let repository: ImageRepository
    
    init(repository: ImageRepository = ImageRepositoryUseCase()) {
        self.repository = repository
    }
    
    func getCover(for book: Book) async {
        do {
            isLoading = true
            let image = try await repository.fetchCover(for: book)
            self.image = image
        } catch {
            Logger.shared.log(error.localizedDescription, level: .error)
        }
        isLoading = false
    }
}
