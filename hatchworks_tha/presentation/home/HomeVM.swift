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
    
    init(client: APIClientProt) {
        Task {
            do {
                amiiboList = try await client.getAmiibos(url: nil)
            } catch(let error) {
                print("HomeVM error:",error.localizedDescription)
            }
        }
    }
}
