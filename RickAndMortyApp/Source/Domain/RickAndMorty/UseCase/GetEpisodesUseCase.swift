//
//  GetEpisodesUseCase.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Foundation

struct GetEpisodesUseCase: UseCase {
    
    struct Query: UseCaseQuery {
        var previousResult: PaginatedResult<Season>?
    }
    
    let repository: RickAndMortyRepository
    
    func buildObservable(_ query: Query) -> Observable<PaginatedResult<Season>> {
        repository.getAllEpisodes(url: query.previousResult?.paginationInfo.nextUrl)
            .tryMap { paginatedEpisodes in
                let regex = try NSRegularExpression(pattern: "^S(\\d+)E(\\d+)$")
                let paginationInfo = paginatedEpisodes.paginationInfo
                let results = paginatedEpisodes.results.reduce(into: query.previousResult?.results ?? [Season]()) { seasons, episode in
                    let range = NSRange(location: 0, length: episode.episodeCode.count)
                    if let match = regex.firstMatch(in: episode.episodeCode, options: [], range: range),
                       let seasonNumberRange = Range(match.range(at: 1), in: episode.episodeCode),
                       let seasonNumber = Int(episode.episodeCode[seasonNumberRange]) {
                        if let seasonIndex = seasons.firstIndex(where: { $0.seasonNumber == seasonNumber }) {
                            seasons[seasonIndex].episodes.append(episode)
                        } else {
                            seasons.append(Season(seasonNumber: seasonNumber, episodes: [episode]))
                        }
                    }
                }
                return PaginatedResult<Season>(paginationInfo: paginationInfo, results: results)
            }
            .asObservable()
    }
    
    
}
