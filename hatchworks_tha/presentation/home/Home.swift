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
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVStack {
                        ForEach(vm.amiiboList, id: \.id) { amiibo in
                            NavigationLink(
                                destination: Detail(amiibo: amiibo),
                                label: {
                                    AmiiboRow(amiibo: amiibo)
                                })
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Amiibo Listing Buddy"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
