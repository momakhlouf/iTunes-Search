//
//  AlbumListView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 30/12/2023.
//

import SwiftUI

struct AlbumListView: View {
    @ObservedObject var viewModel : AlbumViewModel
    var body: some View {
        
                List{
                    ForEach(viewModel.albums, id: \.id) { album in
                       AlbumRowView(album: album)
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
    AlbumListView(viewModel: AlbumViewModel())
}
