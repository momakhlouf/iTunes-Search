//
//  MovieSectionView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct MovieSectionView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack(alignment:.top){
                ForEach(movies) { movie in
                    VStack(alignment:.leading ){
                        ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
                        Text(movie.trackName)
                        Text(movie.primaryGenreName)
                            .foregroundStyle(.gray)
                }
                    .lineLimit(2)
                    .frame(width: 100)
                    .font(.caption)
                }
            }
            .padding([.horizontal, .bottom])
        }

    }
}

#Preview {
    MovieSectionView(movies: [Movie.mockMovie()])
}
