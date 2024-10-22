//
//  Untitled.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

final class CharacterMapper: BaseMapper<CharacterDTO, Character> {
    
    override class func transform(_ dataModel: CharacterDTO) throws -> Character {
        Character(id: dataModel.id,
                  name: dataModel.name,
                  status: Character.Status(rawValue: dataModel.status.lowercased()) ?? .unknown,
                  species: dataModel.species,
                  gender: dataModel.gender,
                  origin: try SimpleLocationMapper.transform(dataModel.origin),
                  location: try SimpleLocationMapper.transform(dataModel.location),
                  imageUrl: dataModel.imageUrl,
                  episodesUrls: dataModel.episodesUrls,
                  created: try dataModel.created.toDate())
    }
    
}

final class SimpleLocationMapper: BaseMapper<SimpleLocationDTO, SimpleLocation> {
    
    override class func transform(_ dataModel: SimpleLocationDTO) throws -> SimpleLocation {
        SimpleLocation(name: dataModel.name,
                       url: dataModel.url)
    }
}
