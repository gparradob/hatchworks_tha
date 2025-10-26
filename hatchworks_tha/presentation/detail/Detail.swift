//
//  Detail.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//
import SwiftUI
import Kingfisher

struct Detail: View {
    @Environment(AmiiboVM.self) var vm
    let amiibo: Amiibo
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: amiibo.image))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(8)
                HStack(spacing: 10) {
                    Text(amiibo.name)
                        .font(.largeTitle)
                        .bold()
                    Button {
                        vm.saveFavorite(amiibo.id)
                    } label: {
                        Image(systemName: vm.favoriteIDs.contains(amiibo.id) ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(.red))
                    }
                }
                
                TextDetail(value: "**Game:** \(amiibo.gameSeries)")
                TextDetail(value: "**Type:** \(amiibo.type)")
                
                if let release = amiibo.release.na {
                    TextDetail(value: "**US Release:** \(release)")
                }
            }
            .padding()
        }
    }
}

struct TextDetail: View {
    var value: String
    
    var body: some View {
        if let attributedString = try? AttributedString(markdown: value) {
            Text(attributedString)
        } else {
            Text(value.replacingOccurrences(of: "*", with: ""))
        }
    }
}

#Preview {
    let amiibo: Amiibo = Amiibo(amiiboSeries: "Animal Crossing", character: "Sandy", gameSeries: "Animal Crossing", image: "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_04380001-03000502.png", name: "Sandy", release: Release(au: nil, eu: nil, jp: nil, na: "2016-12-02"), type: "Card")
    
    Detail(amiibo: amiibo)
}
