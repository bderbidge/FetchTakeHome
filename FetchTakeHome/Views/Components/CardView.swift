//
//  Card.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import SwiftUI

struct CardView: View {
    let recepie: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                if let smallPhotoPath = recepie.smallPhotoPath,
                    let image = UIImage(contentsOfFile: smallPhotoPath) {
                    Image(uiImage: image).resizable()
                } else if let url = recepie.photoUrlSmall {
                    AsyncImage(url: URL(string: url)) { result in
                        if let image = result.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else {
                            ProgressView()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            cardText.padding(.horizontal, 8)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
    }
    
    var cardText: some View {
        VStack(alignment: .leading) {
            Text(recepie.name)
                .lineLimit(nil)
                .font(.headline)
            Text(recepie.cuisine)
                .font(.subheadline)
                
        }.foregroundStyle(.gray)
            .padding(.bottom, 16)
    }
}

#Preview {
    CardView(recepie: .init(uuid: "", cuisine: "Malaysian", name: "Apam Balik", photoUrlLarge: "", photoUrlSmall: "", sourceUrl: "", youtubeUrl: ""))
}
