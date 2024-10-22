//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Foundation

struct EpisodeDTO: Codable {
    var id: Int
    var name: String
    var airDate: String
    var episodeCode: String
    var charactersUrls: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case airDate = "air_date"
        case episodeCode = "episode"
        case charactersUrls = "characters"
        case url
        case created
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(airDate, forKey: .airDate)
        try container.encode(episodeCode, forKey: .episodeCode)
        try container.encode(charactersUrls, forKey: .charactersUrls)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }
}
