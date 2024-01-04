//
//  TrendingView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 02/01/2024.
//

import SwiftUI

struct TrendingView: View {
    @Binding var searchTerm: String
    
    let suggestions = ["golden harry styles", "critical role", "drake 21 savage", "calm down", "beetlejuice"]
    var body: some View {
        VStack(spacing: 20){
            Text("Trending")
                .font(.title.bold())
            ForEach(suggestions, id: \.self){ text in
                Button(action: {
                    searchTerm = text
                }, label: {
                   Text(text)
                })
            }
        }
    }
}

#Preview {
    TrendingView(searchTerm: .constant(""))
}
