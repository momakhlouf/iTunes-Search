//
//  BuyButtonStyle.swift
//  iTunesSearchApp
//
//  Created by Mohamed Makhlouf Ahmed on 04/01/2024.
//

import SwiftUI

struct BuyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.accentColor)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.accentColor, lineWidth: 1)
            }
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

//#Preview {
//    BuyButtonStyle() as! any View
//}
