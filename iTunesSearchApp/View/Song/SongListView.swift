//
//  SongListView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel : SongViewModel
    var body: some View {
                List{
                    ForEach(viewModel.songs) { song in
                        SongRowView(song: song)
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
    SongListView(viewModel: SongViewModel.mockSong())
}


