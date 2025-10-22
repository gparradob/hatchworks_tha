//
//  HomeVM.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//

import Foundation
import Combine

class HomeVM: ObservableObject {
    @Published var amiiboList: [Amiibo] = []
    @Published var searchText: String = ""
    var fullAmiiboList: [Amiibo] = []
    
    init(client: APIClientProt) {
        Task {
            do {
                fullAmiiboList = try await client.getAmiibos(url: nil)
                amiiboList = fullAmiiboList
            } catch(let error) {
                print("HomeVM error:",error.localizedDescription)
            }
        }
    }
    
    func filterAmiibos() {
        if searchText.isEmpty {
            amiiboList = fullAmiiboList
        } else {
            amiiboList = fullAmiiboList.filter { item in
                item.name.lowercased().contains(searchText.lowercased()) ||
                item.gameSeries.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
