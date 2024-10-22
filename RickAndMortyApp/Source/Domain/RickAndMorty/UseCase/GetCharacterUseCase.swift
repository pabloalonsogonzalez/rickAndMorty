//
//  GetCharacterUseCase.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

struct GetCharacterUseCase: UseCase {
    
    struct Query: UseCaseQuery {
        var url: String
    }
    
    let repository: RickAndMortyRepository
    
    func buildObservable(_ query: Query) -> Observable<Character> {
        repository.getCharacter(url: query.url)
    }
    
    
}
