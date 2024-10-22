//
//  GetCharactersUseCase.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

struct GetCharactersUseCase: UseCase {
    
    struct Query: UseCaseQuery {
        var name: String?
        var status: Character.Status?
        var previousResult: PaginatedResult<Character>?
    }
    
    let repository: RickAndMortyRepository
    
    func buildObservable(_ query: Query) -> Observable<PaginatedResult<Character>> {
        if let nextUrl = query.previousResult?.paginationInfo.nextUrl,
           let currentResults = query.previousResult?.results {
            return repository.getCharacters(url: nextUrl)
                .map {
                    PaginatedResult(paginationInfo: $0.paginationInfo,
                                    results: currentResults + $0.results)
                }
                .asObservable()
        }
        return repository.getCharacters(name: query.name?.isEmpty == true ? nil: query.name,
                                        status: query.status)
    }
    
    
}
