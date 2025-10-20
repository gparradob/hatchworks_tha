//
//  Detail.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//
import SwiftUI
import Kingfisher

struct Detail: View {
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
                
                Text(amiibo.name)
                    .font(.largeTitle)
                    .bold()
                
                Text(try! AttributedString(markdown: "**Game:** \(amiibo.gameSeries)"))
                Text(try! AttributedString(markdown: "**Type:** \(amiibo.type)"))
                if let release = amiibo.release.na {
                    Text(try! AttributedString(markdown: "**US Release:** \(release)"))
                }
            }
            .padding()
        }
    }
}
