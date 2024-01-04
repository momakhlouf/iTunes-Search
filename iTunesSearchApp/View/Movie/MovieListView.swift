//
//  MovieListView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel : MovieViewModel
    var body: some View {
                List{
                    ForEach(viewModel.movies) { movie in
                       MovieRowView(movie: movie)
                    }
                    switch viewModel.state {
                        case .good:
                            Color.clear
                                .onAppear {
                                    viewModel.loadMore()
                                }
                        case .isLoading:
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(maxWidth: .infinity)
                        case .loadedAll:
                            EmptyView()
                            
                        case .error(let message):
                            Text(message)
                                .foregroundColor(.pink)
                    }
                }
            .listStyle(.plain)
    }
}

#Preview {
    MovieListView(viewModel: MovieViewModel())
}
