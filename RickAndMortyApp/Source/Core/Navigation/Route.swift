//
//  Screen.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    
    case none
    
    case tabBar
    case home
    case episodes
    case profile
    
    case characterDetail(CharacterDetailDependencies)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .tabBar:
            DefaultTabBarAssembler.resolve()
        case .home:
            DefaultHomeAssembler.resolve()
        case .episodes:
            DefaultEpisodesAssembler.resolve()
        case .profile:
            DefaultProfileAssembler.resolve()
        case .characterDetail(let dependencies):
            DefaultCharacterDetailAssembler.resolve(dependencies: dependencies)
        case .none:
            EmptyView()
        }
    }
}
