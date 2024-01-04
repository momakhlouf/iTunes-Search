//
//  TabbarView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView{
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note")
                }
            SongSearchView()
                .tabItem {
                    Label("Songs", systemImage: "music.mic")
                }
            MovieSearchView()
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }
            
        }
    }
}

#Preview {
    TabbarView()
}
