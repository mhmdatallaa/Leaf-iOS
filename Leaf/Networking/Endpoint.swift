//
//  Endpoint.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete   = "DELETE"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var urlRequest: URLRequest? {
        guard var components = URLComponents(string: baseURL + path) else {
            return nil
        }
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        Logger.shared.log(" URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
