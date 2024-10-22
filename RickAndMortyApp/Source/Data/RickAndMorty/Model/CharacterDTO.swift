//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Foundation

struct CharacterDTO: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: SimpleLocationDTO
    var location: SimpleLocationDTO
    var imageUrl: String
    var episodesUrls: [String]
    var created: String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case imageUrl = "image"
        case episodesUrls = "episode"
        case created
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(status, forKey: .status)
        try container.encode(species, forKey: .species)
        try container.encode(gender, forKey: .gender)
        try container.encode(origin, forKey: .origin)
        try container.encode(location, forKey: .location)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(episodesUrls, forKey: .episodesUrls)
        try container.encode(created, forKey: .created)
    }
}

struct SimpleLocationDTO: Codable {
    var name: String
    var url: String
    
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case url
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
}

