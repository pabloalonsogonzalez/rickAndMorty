//
//  RickAndMortyRepositoryMock.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez on 21/10/24.
//
@testable import RickAndMortyApp

class RickAndMortyRepositoryStub: RickAndMortyRepository {
    
    private(set) var getCharactersCallCount = 0
    var getCharactersHandler: ((String?, Character.Status?) -> (Observable<PaginatedResult<Character>>))?
    func getCharacters(name: String?, status: Character.Status?) -> Observable<PaginatedResult<Character>> {
        getCharactersCallCount += 1
        if let getCharactersHandler {
            return getCharactersHandler(name, status)
        }
        return Observable<PaginatedResult<Character>>.just(PaginatedResult<Character>(paginationInfo: PaginationInfo(count: 1, pages: 1),
                                                                                      results: []))
    }
    
    private(set) var getCharactersByUrlCallCount = 0
    var getCharactersByUrlHandler: ((String) -> (Observable<PaginatedResult<Character>>))?
    
    func getCharacters(url: String) -> Observable<PaginatedResult<Character>> {
        getCharactersByUrlCallCount += 1
        if let getCharactersByUrlHandler {
            return getCharactersByUrlHandler(url)
        }
        return Observable<PaginatedResult<Character>>.just(PaginatedResult<Character>(paginationInfo: PaginationInfo(count: 1, pages: 1),
                                                                                      results: []))
    }
    
    private(set) var getCharacterCallCount = 0
    var getCharacterHandler: ((String) -> (Observable<Character>))?
    
    func getCharacter(url: String) -> Observable<Character> {
        getCharacterCallCount += 1
        if let getCharacterHandler {
            return getCharacterHandler(url)
        }
        return Observable<Character>.empty()
    }
    
    private(set) var getLocationCallCount = 0
    var getLocationHandler: ((String) -> (Observable<Location>))?
    
    func getLocation(url: String) -> Observable<Location> {
        getLocationCallCount += 1
        if let getLocationHandler {
            return getLocationHandler(url)
        }
        return Observable<Location>.empty()
    }
    
    private(set) var getEpisodesByIdCallCount = 0
    var getEpisodesByIdHandler: (([String]) -> (Observable<[Episode]>))?
    
    func getEpisodesById(urls: [String]) -> Observable<[Episode]> {
        getEpisodesByIdCallCount += 1
        if let getEpisodesByIdHandler {
            return getEpisodesByIdHandler(urls)
        }
        return Observable<[Episode]>.empty()
    }
    
    private(set) var getAllEpisodesCallCount = 0
    var getAllEpisodesHandler: ((String?) -> (Observable<PaginatedResult<Episode>>))?
    
    func getAllEpisodes(url: String?) -> Observable<PaginatedResult<Episode>> {
        getAllEpisodesCallCount += 1
        if let getAllEpisodesHandler {
            return getAllEpisodesHandler(url)
        }
        return Observable<PaginatedResult<Episode>>.empty()
    }
}
