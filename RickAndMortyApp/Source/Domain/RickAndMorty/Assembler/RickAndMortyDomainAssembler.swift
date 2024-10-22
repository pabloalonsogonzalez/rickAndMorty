//
//  RickAndMortyDomainAssembler.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

protocol RickAndMortyDomainAssembler {
    static func resolve() -> GetCharactersUseCase
    static func resolve() -> GetCharacterUseCase
    static func resolve() -> GetEpisodesUseCase
    static func resolve() -> GetEpisodesByIdUseCase
    static func resolve() -> GetLocationUseCase
}

struct DefaultRickAndMortyDomainAssembler: RickAndMortyDomainAssembler {
    
    static func resolve() -> GetCharactersUseCase {
        GetCharactersUseCase(repository: DefaultRickAndMortyDataAssembler.resolve())
    }
    
    static func resolve() -> GetCharacterUseCase {
        GetCharacterUseCase(repository: DefaultRickAndMortyDataAssembler.resolve())
    }
    
    static func resolve() -> GetEpisodesUseCase {
        GetEpisodesUseCase(repository: DefaultRickAndMortyDataAssembler.resolve())
    }
    
    static func resolve() -> GetEpisodesByIdUseCase {
        GetEpisodesByIdUseCase(repository: DefaultRickAndMortyDataAssembler.resolve())
    }
    
    static func resolve() -> GetLocationUseCase {
        GetLocationUseCase(repository: DefaultRickAndMortyDataAssembler.resolve())
    }
    
}
