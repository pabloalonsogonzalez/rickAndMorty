//
//  GetEpisodeUseCase.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

struct GetEpisodesByIdUseCase: UseCase {
    
    struct Query: UseCaseQuery {
        var urls: [String]
    }
    
    let repository: RickAndMortyRepository
    
    func buildObservable(_ query: Query) -> Observable<[Episode]> {
        repository.getEpisodesById(urls: query.urls)
    }
    
    
}
