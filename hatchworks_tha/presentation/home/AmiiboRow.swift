//
//  AmiiboRow.swift
//  hatchworks_tha
//
//  Created by Gustavo Parrado on 10/19/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct AmiiboRow: View {
    var amiibo: Amiibo
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.gray.opacity(0.3))
                .shadow(radius: 2)
            
            HStack {
                KFImage(URL(string: amiibo.image))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(amiibo.name)
                        .font(.headline)
                    Text(amiibo.gameSeries)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .padding(10)
        }
    }
}
