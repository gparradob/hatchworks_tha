//
//  Amiibo.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/18/25.
//

import Foundation

// MARK: - AmiiboResult
struct AmiiboResult: nonisolated Codable {
    let amiibo: [Amiibo]
}

// MARK: - Amiibo
struct Amiibo: Codable, Identifiable {
    let id: String = UUID().uuidString
    let amiiboSeries, character, gameSeries, head: String
    let image: String
    let name: String
    let release: Release
    let tail, type: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amiiboSeries = try container.decode(String.self, forKey: .amiiboSeries)
        self.character = try container.decode(String.self, forKey: .character)
        self.gameSeries = try container.decode(String.self, forKey: .gameSeries)
        self.head = try container.decode(String.self, forKey: .head)
        self.image = try container.decode(String.self, forKey: .image)
        self.name = try container.decode(String.self, forKey: .name)
        self.release = try container.decode(Release.self, forKey: .release)
        self.tail = try container.decode(String.self, forKey: .tail)
        self.type = try container.decode(String.self, forKey: .type)
    }
    
    enum CodingKeys: String, CodingKey {
        case amiiboSeries, character, gameSeries, head, image, name, release, tail, type
    }
    
}

// MARK: - Release
struct Release: Codable {
    let au, eu, jp, na: String?
}
