//
//  EpisodeMapper.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

final class EpisodeMapper: BaseMapper<EpisodeDTO, Episode> {
    
    override class func transform(_ dataModel: EpisodeDTO) throws -> Episode {
        Episode(id: dataModel.id,
                name: dataModel.name,
                airDate: try dataModel.airDate.toDate(),
                episodeCode: dataModel.episodeCode,
                charactersUrls: dataModel.charactersUrls,
                url: dataModel.url,
                created: try dataModel.created.toDate())
    }
}
