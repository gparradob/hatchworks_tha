//
//  ContentView.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/25/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AmiiboVM.self) var vm
    @Environment(\.showToast) var showToast
    
    var body: some View {
        @Bindable var vm = vm
        TabView {
            AmiiboListing(amiiboList: $vm.amiiboList,
                          filterAction: vm.filterAmiibos,
                          title: "Amiibo Listing Buddy")
                .navigationTitle("Amiibo Listing")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            AmiiboListing(amiiboList: $vm.favoritesList,
                          filterAction: vm.filterFavorites,
                          title: "Favorites")
                .navigationTitle("Favorites")
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(1)
        }
        .task {
            do {
                try await vm.loadData()
            } catch {
                showToast(.error("Failed to load data"))
            }
        }
    }
}

#Preview {
    ContentView()
        .toastable()
        .environment(AmiiboVM(client: MockAPIClient()))
}
