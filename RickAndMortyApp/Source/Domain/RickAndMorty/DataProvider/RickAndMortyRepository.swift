//
//  RickAndMortyRepository.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Combine

enum RickAndMortyError: Error {
    case noCharactersFound
}

protocol RickAndMortyRepository {
    func getCharacters(name: String?,
                       status: Character.Status?) -> Observable<PaginatedResult<Character>>
    func getCharacters(url: String) -> Observable<PaginatedResult<Character>>
    func getCharacter(url: String) -> Observable<Character>
    func getLocation(url: String) -> Observable<Location>
    func getEpisodesById(urls: [String]) -> Observable<[Episode]>
    func getAllEpisodes(url: String?) -> Observable<PaginatedResult<Episode>>
}
