//
//  ImageLoadingView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct ImageLoadingView: View {
    let urlString : String
    let size: CGFloat
            var body: some View {
                AsyncImage(url: URL(string: urlString)) { image in
                    image
                        .resizable()
                        .border(Color.white.opacity(0.8))
                   //     .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: size,height: size)
            }
}

#Preview {
    ImageLoadingView(urlString: "", size: 1)
}
