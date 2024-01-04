//
//  AlbumSearchView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct AlbumSearchView: View {
    @StateObject var viewModel = AlbumViewModel()
    var body: some View {
        NavigationStack{
            Group{
                if viewModel.searchTerm.isEmpty{
                    TrendingView(searchTerm: $viewModel.searchTerm)
                }else{
                    AlbumListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
        }
    }
}

#Preview {
    AlbumSearchView()
}
