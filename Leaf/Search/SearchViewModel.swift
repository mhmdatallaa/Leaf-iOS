//
//  SearchViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var subjects: [String] = [ "fiction", "fantasy", "romance", "history", "science", "biography", "self-help"]
}
