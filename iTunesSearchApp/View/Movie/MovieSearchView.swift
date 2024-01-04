//
//  MovieSearchView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModel = MovieViewModel()
    var body: some View {
        NavigationStack{
            Group{
                if viewModel.searchTerm.isEmpty{
                //    AlbumTrendingView(searchTerm: $viewModel.searchTerm)
                }else{
                    MovieListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
        }
    }
}

#Preview {
    MovieSearchView()
}
