//
//  ClientProtocol.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/26/25.
//
import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError(Error)
    case networkError(Error)
}

protocol ClientProtocol {
    func getAmiibos() async throws -> [Amiibo]
}
