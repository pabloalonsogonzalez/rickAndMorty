//
//  LoaderView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez on 1/9/24.
//

import SwiftUI

struct LoaderView: View {
    @State private var degrees = 0.0
    var body: some View {
        ZStack {
            Color(.background)
            LoaderImage(size: 100)
        }
    }
}

struct LoaderImage: View {
    let size: CGFloat
    @State private var degrees = 0.0
    
    var body: some View {
        Image(.loader)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .onAppear() {
                withAnimation(Animation
                    .bouncy
                    .repeatForever()) {
                        degrees += 360
                    }
            }
            .rotationEffect(.degrees(degrees))
    }
}

#Preview {
    LoaderView()
}
