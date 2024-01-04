//
//  SongSectionView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct SongSectionView: View {
    let songs: [Song]
    let rows = Array(repeating: GridItem(.fixed(60), spacing: 0), count: 4)
    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: rows, spacing: 15){
                ForEach(songs) { song in
                    HStack{
                       SongRowView(song: song)
                            .frame(width: 300)
                    }
                }
            }
           
        }
    }
}

#Preview {
    SongSectionView(songs: [Song.mockSong()])
}
