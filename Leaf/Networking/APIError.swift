//
//  APIError.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed
    case serverError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: "Invalid URL"
        case .requestFailed: "Request failed"
        case .decodingFailed: "Failed to decode response"
        case .serverError(let code): "Server error: \(code)"
        }
    }
}
