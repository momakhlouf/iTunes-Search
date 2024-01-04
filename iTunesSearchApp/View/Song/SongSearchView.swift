//
//  SongSearchView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct SongSearchView: View {
    @StateObject var viewModel = SongViewModel()
    var body: some View {
        NavigationStack{
            Group{
                if viewModel.searchTerm.isEmpty{
                //    AlbumTrendingView(searchTerm: $viewModel.searchTerm)
                }else{
                    SongListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
        }
    }
}

#Preview {
    SongSearchView()
}
