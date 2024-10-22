//
//  LastRowView.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import SwiftUI

struct LastRowView: View {
    
    @Binding var canLoadMore: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            if canLoadMore {
                LoaderImage(size: 50)
            } else {
                EmptyView()
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
}
