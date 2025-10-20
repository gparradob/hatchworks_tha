//
//  APIClient.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/18/25.
//
import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case networkError(Error)
}

protocol APIClientProt {
    func getAmiibos(url: URL?) async throws -> [Amiibo]
}

class APIClient: APIClientProt {
    private let APIUrl = URL(string: "https://amiiboapi.com/api/amiibo")!
    
    let session = URLSession.shared
    
    func getAmiibos(url: URL? = nil) async throws -> [Amiibo] {
        var request = URLRequest(url: url ?? APIUrl)
        request.cachePolicy = .returnCacheDataElseLoad
        do {
            let (data, _) = try await session.data(for: request)
            
            do {
                let decoded = try JSONDecoder().decode(AmiiboResult.self, from: data)
                return decoded.amiibo
            } catch let error {
                throw APIError.decodingError(error)
            }
        } catch let error as APIError {
            throw error
        } catch let error {
            throw APIError.networkError(error)
        }
    }
}
