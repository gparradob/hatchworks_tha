//
//  hatchworks_thaTests.swift
//  hatchworks_thaTests
//
//  Created by Gustavo Parrado on 10/18/25.
//

import Testing
import Foundation
@testable import hatchworks_tha

struct hatchworks_thaTests {
    let client: ClientProtocol
    
    @MainActor
    init() throws {
        client = MockAPIClient()
    }
    
    @MainActor
    @Test func testHomeVM() async throws {
        let vm = AmiiboVM(client: client)
        do {
            try await vm.loadData()
        } catch {
            Issue.record("Failed to load data: \(error)")
            return
        }
        // Verify data loaded as expected
        #expect(!vm.amiiboList.isEmpty, "Amiibo list should not be empty after loading")
    }
    
    @MainActor
    @Test("search within full amiibo list")
    func testAmiiboSearch() async {
        let vm = AmiiboVM(client: client)
        do {
            try await vm.loadData()
        } catch {
            Issue.record("Failed to load data: \(error)")
            return
        }
        // Verify data loaded as expected
        #expect(!vm.amiiboList.isEmpty, "Amiibo list should not be empty after loading")
        
        vm.filterAmiibos("Sonic")
        #expect(vm.amiiboList.count == 1, "Should find 1 amiibo that says 'Sonic' in its name")
    }
    
    @MainActor
    @Test("save favorite")
    func testAddToFavorites() async {
        let store = DefaultsStorage()
        store.save(Set([]))
        var vm = AmiiboVM(client: client)
        do {
            try await vm.loadData()
        } catch {
            Issue.record("Failed to load data: \(error)")
            return
        }
        // Verify data loaded as expected
        #expect(!vm.amiiboList.isEmpty, "Amiibo list should not be empty after loading")
        
        vm.filterAmiibos("punchy")
        if let first = vm.amiiboList.first {
            vm.saveFavorite(first.id)
        }
        #expect(vm.favoriteIDs.count == 1, "Should have 1 amiibo in favorites")
        
        // reload vm to load favorites from storage
        vm = AmiiboVM(client: client)
        #expect(vm.favoriteIDs.count == 1, "Should still have 1 amiibo in favorites after reloading")
    }
    
    
    @MainActor
    @Test("search within favorites list")
    func testFavoriteSearch() async {
        let store = DefaultsStorage()
        store.save(Set([]))
        let vm = AmiiboVM(client: client)
        do {
            try await vm.loadData()
        } catch {
            Issue.record("Failed to load data: \(error)")
            return
        }
        // Verify data loaded as expected
        #expect(!vm.amiiboList.isEmpty, "Amiibo list should not be empty after loading")
        
        vm.filterAmiibos("Sonic")
        if let first = vm.amiiboList.first {
            vm.saveFavorite(first.id)
        }
        #expect(vm.favoriteIDs.count == 1, "Should have 1 amiibo in favorites")
        
        vm.filterFavorites("Sonic")
        #expect(vm.favoritesList.count == 1, "Should find 1 amiibo that says 'Sonic' in its name in the favorites")
    }
}
