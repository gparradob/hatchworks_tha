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
    let id: String
    let amiiboSeries, character, gameSeries: String
    let image: String
    let name: String
    let release: Release
    let type: String
    let head: String = ""
    let tail: String = ""
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amiiboSeries = try container.decode(String.self, forKey: .amiiboSeries)
        self.character = try container.decode(String.self, forKey: .character)
        self.gameSeries = try container.decode(String.self, forKey: .gameSeries)
        self.image = try container.decode(String.self, forKey: .image)
        self.name = try container.decode(String.self, forKey: .name)
        self.release = try container.decode(Release.self, forKey: .release)
        self.type = try container.decode(String.self, forKey: .type)
        self.id = "\(try container.decode(String.self, forKey: .head))\(try container.decode(String.self, forKey: .tail))"
    }
    
    init(amiiboSeries: String, character: String, gameSeries: String, image: String, name: String, release: Release, type: String) {
        self.amiiboSeries = amiiboSeries
        self.character = character
        self.gameSeries = gameSeries
        self.image = image
        self.name = name
        self.release = release
        self.type = type
        self.id = UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case amiiboSeries, character, gameSeries, image, name, release, type, head, tail
    }
    
}

// MARK: - Release
struct Release: Codable {
    let au, eu, jp, na: String?
}
