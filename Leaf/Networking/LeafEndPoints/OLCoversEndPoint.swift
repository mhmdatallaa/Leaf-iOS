//
//  OLCoversAPI.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//
// cover: https://covers.openlibrary.org/b/id/12818862-L.jpg

import Foundation

enum OLCoversEndPoint: Endpoint {

    case bookCover(id: Int, size: BookCoverSize)

    var baseURL: String { "https://covers.openlibrary.org" }
    var path: String {
        switch self {
        case .bookCover(let id, let size): "/b/id/\(id)-\(size.rawValue).jpg"
        }
    }
    var method: HTTPMethod { .get }
    var headers: [String : String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
    
    
}
