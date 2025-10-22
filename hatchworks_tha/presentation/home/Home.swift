//
//  Home.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//
import SwiftUI

struct Home: View {
    @ObservedObject var vm = HomeVM(client: APIClient())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                List {
                    ForEach(vm.amiiboList, id: \.id) { amiibo in
                        NavigationLink(
                            destination: Detail(amiibo: amiibo),
                            label: {
                                AmiiboRow(amiibo: amiibo)
                            })
                    }
                }
                .searchable(text: $vm.searchText)
                .textInputAutocapitalization(.never)
                .onChange(of: vm.searchText) {
                    vm.filterAmiibos()
                }
            }
            .navigationTitle(Text("Amiibo Listing Buddy"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
