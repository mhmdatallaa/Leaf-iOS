//
//  NetworkService.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() { }
    
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        guard let request = endpoint.urlRequest else {
            throw APIError.invalidURL
        }
        
        Logger.shared.log("\(request)")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}

extension NetworkService {
    func requestData(_ endpoint: Endpoint) async throws -> Data {
        guard let request = endpoint.urlRequest else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }
        
        return data
    }
}
