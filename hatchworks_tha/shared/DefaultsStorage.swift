//
//  DefaultsStorage.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/26/25.
//

import Foundation

struct DefaultsStorage: DataStorage {
    private let key: String = "amiiboListing.favorites"
    
    func save(_ favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
    }
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: key) ?? []
        return Set(array)
    }
}
