//
//  MovieRowView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
            
            VStack(alignment: .leading) {
                Text(movie.trackName)
                Text(movie.primaryGenreName)
                    .foregroundColor(.gray)
                Text(movie.releaseDate)
                    
            }
            .font(.caption)
            
            Spacer(minLength: 20)
          
            BuyButtonView(urlString: movie.previewURL ?? "",
                      price: movie.trackPrice,
                      currency: movie.currency)
        }
    }
}

#Preview {
    MovieRowView(movie: Movie.mockMovie())
}
