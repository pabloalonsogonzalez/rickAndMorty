//
//  EpisodesAssembler.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation

protocol EpisodesAssembler {
    static func resolve() -> EpisodesView
    static func resolve() -> EpisodesViewModel
}

struct DefaultEpisodesAssembler: EpisodesAssembler {
    static func resolve() -> EpisodesView {
        EpisodesView(viewModel: resolve())
    }
    static func resolve() -> EpisodesViewModel {
        EpisodesViewModel(getEpisodesUseCase: DefaultRickAndMortyDomainAssembler.resolve())
    }
}
