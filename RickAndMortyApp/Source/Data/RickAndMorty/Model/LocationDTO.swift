//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Foundation

struct LocationDTO: Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residentsUrls: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case type
        case dimension
        case residentsUrls = "residents"
        case url
        case created
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(dimension, forKey: .dimension)
        try container.encode(residentsUrls, forKey: .residentsUrls)
        try container.encode(url, forKey: .url)
        try container.encode(created, forKey: .created)
    }
}
