//
//  MockAPIClient.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/23/25.
//

import Foundation

struct MockAPIClient: ClientProtocol {
    func getAmiibos() async throws -> [Amiibo] {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: "mock", withExtension: "json") else {
            throw NSError(domain: "MockApiClient", code: 1, userInfo: [NSLocalizedDescriptionKey: "mock.json not found in bundle"])
        }
        let data = try Data(contentsOf: url)
        let result = try JSONDecoder().decode(hatchworks_tha.AmiiboResult.self, from: data)
        return result.amiibo
    }
}

import Playgrounds

#Playground {
    let client = MockAPIClient()
    do {
        let amiibos = try await client.getAmiibos()
    }
}
