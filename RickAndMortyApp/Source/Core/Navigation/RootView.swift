//
//  RootView.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI

class PresentedScreen: ObservableObject {
    @Published var currentScreen: Route = .tabBar
}

struct RootView: View {
    @EnvironmentObject var presentedScreen: PresentedScreen
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            presentedScreen.currentScreen.view
        }
    }
}

#Preview {
    RootView().environmentObject(PresentedScreen())
}
