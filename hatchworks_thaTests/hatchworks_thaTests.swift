//
//  hatchworks_thaTests.swift
//  hatchworks_thaTests
//
//  Created by Gustavo Parrado on 10/18/25.
//

import Testing
import Foundation
@testable import hatchworks_tha

class MockApiClient: APIClientProt {
    func getAmiibos(url: URL? = nil) async throws -> [hatchworks_tha.Amiibo] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "mock", withExtension: "json") else {
            throw NSError(domain: "MockApiClient", code: 1, userInfo: [NSLocalizedDescriptionKey: "mock.json not found in bundle"])
        }
        let data = try Data(contentsOf: url)
        let result = try JSONDecoder().decode(hatchworks_tha.AmiiboResult.self, from: data)
        return result.amiibo
    }
    
    func getFileURL(forResource name: String, withExtension ext: String) -> URL? {
        return Bundle(for: type(of: self)).url(forResource: name, withExtension: ext)
    }
}

struct hatchworks_thaTests {

    @Test func testHomeVM() async throws {
        let vm = await HomeVM(client: MockApiClient())
        #expect(vm.amiiboList.count > 0)
    }
    
    @Test func testApiClient() async throws {
        let helper = MockApiClient()
        let localUrl = helper.getFileURL(forResource: "mock", withExtension: "json")
        
        let client = await APIClient()
        let data = try await client.getAmiibos(url: localUrl)
        #expect(data.count == 12)
    }

}
