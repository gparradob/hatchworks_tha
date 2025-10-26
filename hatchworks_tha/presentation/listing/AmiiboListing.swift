//
//  Home.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//
import SwiftUI

struct AmiiboListing: View {
    @Environment(\.showToast) private var showToast
    @Binding var amiiboList: [Amiibo]
    var filterAction: (String) -> Void
    var title: String

    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                List {
                    ForEach(amiiboList, id: \.id) { amiibo in
                        NavigationLink(
                            destination: Detail(amiibo: amiibo),
                            label: {
                                AmiiboRow(amiibo: amiibo)
                            })
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .textInputAutocapitalization(.never)
                .onChange(of: searchText) {
                    filterAction(searchText)
                }
            }
            .navigationTitle(Text(title))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    @State @Previewable var vm = AmiiboVM(client: MockAPIClient())
    
    AmiiboListing(
        amiiboList: $vm.amiiboList,
        filterAction: vm.filterAmiibos,
        title: "Amiibo Listing Buddy"
    )
}
