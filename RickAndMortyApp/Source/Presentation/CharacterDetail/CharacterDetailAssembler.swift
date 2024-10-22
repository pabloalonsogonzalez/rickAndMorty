//
//  CharacterDetail.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation

struct CharacterDetailDependencies: Hashable {
    var character: Character
}

protocol CharacterDetailAssembler {
    static func resolve(dependencies: CharacterDetailDependencies) -> CharacterDetailView
    static func resolve(dependencies: CharacterDetailDependencies) -> CharacterDetailViewModel
}

struct DefaultCharacterDetailAssembler: CharacterDetailAssembler {

    static func resolve(dependencies: CharacterDetailDependencies) -> CharacterDetailView {
        CharacterDetailView(viewModel: resolve(dependencies: dependencies))
    }
    static func resolve(dependencies: CharacterDetailDependencies) -> CharacterDetailViewModel {
        CharacterDetailViewModel(dependencies: dependencies,
                                 getEpisodesByIdUseCase: DefaultRickAndMortyDomainAssembler.resolve())
    }
}
