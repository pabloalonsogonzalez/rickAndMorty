//
//  RickAndMortyAssembler.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

protocol RickAndMortyDataAssembler {
    static func resolve() -> RickAndMortyRepository
}

struct DefaultRickAndMortyDataAssembler: RickAndMortyDataAssembler {
    static func resolve() -> RickAndMortyRepository {
        DefaultRickAndMortyRepository()
    }
}
