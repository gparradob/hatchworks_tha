//
//  APIClient.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/18/25.
//
import Foundation

struct APIClient: ClientProtocol {
    private let APIUrl = "https://amiiboapi.com/api/amiibo"
    
    let session = URLSession.shared
    
    func getAmiibos() async throws -> [Amiibo] {
        guard let requestURL = URL(string: APIUrl) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: requestURL)
        request.cachePolicy = .returnCacheDataElseLoad
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
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
