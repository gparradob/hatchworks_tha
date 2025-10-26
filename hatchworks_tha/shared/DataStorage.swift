//
//  DataStorage.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/26/25.
//

import Foundation

protocol DataStorage {
    func save(_ favoriteIDs: Set<String>)
    func load() -> Set<String>
}
