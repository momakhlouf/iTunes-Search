//
//  SongRowView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct SongRowView: View {
    let song: Song
    var body: some View {
        HStack{
            ImageLoadingView(urlString: song.artworkUrl60, size: 60)

            VStack(alignment: .leading){
                Text(song.trackName )
                Text(song.artistName  + " - " + (song.collectionName ))
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            Spacer(minLength: 25)
            
            BuyButtonView(urlString: song.trackViewURL, price: song.trackPrice, currency: song.currency)
        }
    }
}

#Preview {
    SongRowView(song: Song.mockSong())
}
