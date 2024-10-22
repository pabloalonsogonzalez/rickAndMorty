//
//  GetLocationUseCase.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

struct GetLocationUseCase: UseCase {
    
    struct Query: UseCaseQuery {
        var url: String
    }
    
    let repository: RickAndMortyRepository
    
    func buildObservable(_ query: Query) -> Observable<Location> {
        repository.getLocation(url: query.url)
    }
    
    
}
