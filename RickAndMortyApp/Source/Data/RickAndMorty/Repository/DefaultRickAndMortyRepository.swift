//
//  DefaultRickAndMortyRepository.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Foundation

class DefaultRickAndMortyRepository: BaseRepository, RickAndMortyRepository {
    
    func getCharacters(name: String?, status: Character.Status?) -> Observable<PaginatedResult<Character>> {
        executeRequestByUrl(RickAndMortyConstants.basePath + RickAndMortyConstants.characterPath,
                            queryItems: [URLQueryItem(name: RickAndMortyConstants.nameQueryItem, value: name),
                                         URLQueryItem(name: RickAndMortyConstants.statusQueryItem, value: status?.rawValue)],
                            mapFunction: PaginatedResultMapper(CharacterMapper.listTransform).transform)
        .mapError { error -> Error in
            if let errorResponse = error as? ErrorResponse,
               errorResponse.code == 404 {
                return RickAndMortyError.noCharactersFound
            }
            return error
        }
        .asObservable()
    }
    
    func getCharacters(url: String) -> Observable<PaginatedResult<Character>> {
        executeRequestByUrl(url, mapFunction: PaginatedResultMapper(CharacterMapper.listTransform).transform)
    }
    
    func getCharacter(url: String) -> Observable<Character> {
        executeRequestByUrl(url, mapFunction: CharacterMapper.transform)
    }
    
    func getLocation(url: String) -> Observable<Location> {
        executeRequestByUrl(url, mapFunction: LocationMapper.transform)
    }
    
    func getEpisodesById(urls: [String]) -> Observable<[Episode]> {
        let url = RickAndMortyConstants.basePath
        + RickAndMortyConstants.episodePath + "/"
        + urls.map { NSString(string: $0).lastPathComponent }.joined(separator: ",")
        if urls.count == 1 {
            return executeRequestByUrl(url,
                                       mapFunction: EpisodeMapper.transform)
            .map { [$0] }
            .asObservable()
        }
        return executeRequestByUrl(url,
                            mapFunction: EpisodeMapper.listTransform)
    }
    
    func getAllEpisodes(url: String?) -> Observable<PaginatedResult<Episode>> {
        if let url {
            return executeRequestByUrl(url, mapFunction: PaginatedResultMapper(EpisodeMapper.listTransform).transform)
        }
        return executeRequestByUrl(RickAndMortyConstants.basePath + RickAndMortyConstants.episodePath,
                                   mapFunction: PaginatedResultMapper(EpisodeMapper.listTransform).transform)
    }
}
