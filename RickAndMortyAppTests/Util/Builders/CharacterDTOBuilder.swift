//
//  CharacterDTOBuilder.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez on 21/10/24.
//


import Foundation
@testable import RickAndMortyApp

class CharacterDTOBuilder: BaseDTOBuilder {
    
    public var id: Int = 1
    public var name: String = "Rick"
    public var status: String = "Alive"
    public var species: String = "Human"
    public var gender: String = "Male"
    public var origin: SimpleLocationDTO = SimpleLocationDTOBuilder().build()
    public var location: SimpleLocationDTO = SimpleLocationDTOBuilder().build()
    public var imageUrl: String = "imageURL"
    public var episodesUrls: [String] = ["episode1URL", "episode2URL"]
    public var created: String = "2021-10-15T17:00:24.105Z"
    
    func build() -> CharacterDTO {
        return CharacterDTO(id: id,
                            name: name,
                            status: status,
                            species: species,
                            gender: gender,
                            origin: origin,
                            location: location,
                            imageUrl: imageUrl,
                            episodesUrls: episodesUrls,
                            created: created)
    }
    
    func id(_ id: Int) -> CharacterDTOBuilder {
        self.id = id
        return self
    }
    
    func name(_ name: String) -> CharacterDTOBuilder {
        self.name = name
        return self
    }
    
    func status(_ status: Character.Status) -> CharacterDTOBuilder {
        self.status = status.rawValue
        return self
    }
    
    func species(_ species: String) -> CharacterDTOBuilder {
        self.species = species
        return self
    }
    
    func gender(_ gender: String) -> CharacterDTOBuilder {
        self.gender = gender
        return self
    }
    
    func origin(_ origin: SimpleLocationDTO) -> CharacterDTOBuilder {
        self.origin = origin
        return self
    }
    
    func location(_ location: SimpleLocationDTO) -> CharacterDTOBuilder {
        self.location = location
        return self
    }
    
    func imageUrl(_ imageUrl: String) -> CharacterDTOBuilder {
        self.imageUrl = imageUrl
        return self
    }
    
    func episodesUrls(_ episodesUrls: [String]) -> CharacterDTOBuilder {
        self.episodesUrls = episodesUrls
        return self
    }
    
    func created(_ created: String) -> CharacterDTOBuilder {
        self.created = created
        return self
    }
    
}
