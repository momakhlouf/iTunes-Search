//
//  SearchView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct SearchView: View {
    @State var searchTerm: String = ""
    @State var selectedEntityType = EntityType.all
    
    @StateObject var albumViewModel = AlbumViewModel()
    @StateObject var songViewModel = SongViewModel()
    @StateObject var movieViewModel = MovieViewModel()

     
    var body: some View {
        NavigationStack{
            VStack{
                if !searchTerm.isEmpty{
                
                Picker("Select", selection: $selectedEntityType){
                    ForEach(EntityType.allCases){ type in
                        Text(type.name())
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Divider()
            }
                
                if searchTerm.count == 0 {
                    TrendingView(searchTerm: $searchTerm)
                }else{
                    switch selectedEntityType {
                    case .all:
                        SearchAllListView(albumViewModel: albumViewModel, songViewModel: songViewModel, movieViewModel: movieViewModel)
                            .onAppear{
                                albumViewModel.searchTerm = searchTerm
                                songViewModel.searchTerm = searchTerm
                                movieViewModel.searchTerm = searchTerm
                            }
                    case .album:
                        AlbumListView(viewModel: albumViewModel)
                            .onAppear{
                                albumViewModel.searchTerm = searchTerm
                            }
                    case .song:
                        SongListView(viewModel: songViewModel)
                            .onAppear{
                                songViewModel.searchTerm = searchTerm
                            }
                    case .movie:
                        MovieListView(viewModel: movieViewModel)
                            .onAppear{
                                movieViewModel.searchTerm = searchTerm
                            }
                    }
                }
             
             
                Spacer()
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchTerm) { newValue in
            
            switch selectedEntityType {
            case .all:
                albumViewModel.searchTerm = newValue
                songViewModel.searchTerm = newValue
                movieViewModel.searchTerm = newValue
            case .album:
                albumViewModel.searchTerm = newValue
            case .song:
                songViewModel.searchTerm = newValue
            case .movie:
                movieViewModel.searchTerm = newValue

            }
        

        }
    }
}

#Preview {
    SearchView()
}
