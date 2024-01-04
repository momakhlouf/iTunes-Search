//
//  SearchAllListView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct SearchAllListView: View {
    @ObservedObject var albumViewModel: AlbumViewModel
    @ObservedObject var songViewModel: SongViewModel
    @ObservedObject var movieViewModel: MovieViewModel
    
    var body: some View {
        ScrollView{
            LazyVStack{
                if songViewModel.songs.count > 0{
                    SectionHeaderView(title: "Songs") {
                        SongListView(viewModel: songViewModel)
                    }
                }
                SongSectionView(songs: songViewModel.songs)
                
                Divider()
                    .padding(.bottom)
                
          
                if movieViewModel.movies.count > 0{
                    SectionHeaderView(title: "Movies") {
                        MovieListView(viewModel: movieViewModel)
                    }
                }
               
                MovieSectionView(movies: movieViewModel.movies)
                
                Divider()
                    .padding(.bottom)
                
                if albumViewModel.albums.count > 0{
                    SectionHeaderView(title: "Albums") {
                        AlbumListView(viewModel: albumViewModel)
                    }
                }
                AlbumSectionView(albums: albumViewModel.albums)
            }
        }
    }
}


struct SectionHeaderView<Destination>: View where Destination : View {
    
    let title: String
    let destination:  () -> Destination
    
    init(title: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            
            NavigationLink(destination: destination) {
                HStack {
                    Text("See all")
                    Image(systemName: "chevron.right")
                }
                .font(.headline)

            }
        }
        .foregroundStyle(.gray)
        .padding(.horizontal)
    }
}

#Preview {
    SearchAllListView(albumViewModel: AlbumViewModel.mockAlbum(), songViewModel: SongViewModel.mockSong(), movieViewModel: MovieViewModel.mockMovie())
}


