//
//  BuyButtonView.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct BuyButtonView: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url =  URL(string: urlString),
            let price = price {
            Link(destination: url) {
                Text("\(Int(price)) \(currency)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
}

//#Preview {
//    let ex = Song.mockSong()
//    BuyButtonView(urlString: ex.previewURL, price: ex.trackPrice, currency: ex.currency)
//}
