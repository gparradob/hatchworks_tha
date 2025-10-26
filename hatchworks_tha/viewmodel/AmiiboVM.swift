//
//  HomeVM.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//

import Foundation
import Observation

@Observable
class AmiiboVM {
    private var storage: DataStorage
    private(set) var client: ClientProtocol
    
    var amiiboList: [Amiibo] = []
    var favoritesList: [Amiibo] = []
    private(set) var favoriteIDs: Set<String> = []
    private var fullAmiiboList: [Amiibo] = []
    private var fullFavoritesList: [Amiibo] = []
    
    init(client: ClientProtocol, storage: DataStorage = DefaultsStorage()) {
        self.client = client
        self.storage = storage
        favoriteIDs = storage.load()
    }
    
    func loadData() async throws {
        do {
            fullAmiiboList = try await client.getAmiibos()
            amiiboList = fullAmiiboList
            refreshFavorites()
        } catch(let error) {
            throw error
        }
    }
    
    private func refreshFavorites() {
        fullFavoritesList = fullAmiiboList.filter { item in
            favoriteIDs.contains(item.id)
        }
        favoritesList = fullFavoritesList
    }
    
    private func performSearch(_ searchText: String, fullList: [Amiibo], resultList: inout [Amiibo]) {
        if searchText.isEmpty {
            resultList = fullList
        } else {
            resultList = fullList.filter { item in
                item.name.lowercased().contains(searchText.lowercased()) ||
                item.gameSeries.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func filterAmiibos(_ searchText: String) {
        performSearch(searchText, fullList: fullAmiiboList, resultList: &amiiboList)
    }
    
    func filterFavorites(_ searchText: String) {
        performSearch(searchText, fullList: fullFavoritesList, resultList: &favoritesList)
    }
    
    func saveFavorite(_ id: String) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
        refreshFavorites()
        storage.save(favoriteIDs)
    }
}
