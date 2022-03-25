//
//  AsyncImageCustom.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 24/03/22.
//

import SwiftUI

struct AsyncImageCustom: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, height: height)
        .clipShape(Circle())
        .shadow(color: .black, radius: 8, x: 0, y: 0)
    }
}

