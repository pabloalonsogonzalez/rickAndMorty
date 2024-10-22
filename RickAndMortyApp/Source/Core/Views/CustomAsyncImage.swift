//
//  CustomAsyncView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez on 3/9/24.
//

import SwiftUI
import NukeUI

struct CustomAsyncImage: View {
    let url: URL?
    let size: CGFloat
    init(url: String,
         size: CGFloat) {
        self.url = URL(string: url)
        self.size = size
    }
    
    var body: some View {
        if let url = url {
            LazyImage(url: url) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                } else if state.error != nil {
                    imageNotAvailable
                        .frame(width: size, height: size)
                } else {
                    ProgressView()
                        .frame(width: size, height: size)
                }
                
            }
//            AsyncImage(url: url) { phase in
//                if let image = phase.image {
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: size, height: size)
//                } else if phase.error != nil {
//                    imageNotAvailable
//                        .frame(width: size, height: size)
//                } else {
//                    ProgressView()
//                        .frame(width: size, height: size)
//                }
//            }
        } else {
            imageNotAvailable
                .frame(width: size, height: size)
        }
    }
    
    private var imageNotAvailable: some View {
        Image(systemName: "xmark.icloud")
            .resizable()
            .scaledToFit()
            .padding(5)
    }
}
