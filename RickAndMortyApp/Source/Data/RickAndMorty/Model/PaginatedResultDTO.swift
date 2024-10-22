//
//  PaginationInfoDTO.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

struct PaginatedResultDTO<T: Codable>: Codable {
    var info: PaginationInfoDTO
    var results: [T]
    
    enum CodinKeys: String, CodingKey, CaseIterable {
        case info
        case results
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodinKeys.self)
        try container.encode(info, forKey: .info)
        try container.encode(results, forKey: .results)
    }
}

struct PaginationInfoDTO: Codable {
    var count: Int
    var pages: Int
    var nextUrl: String?
    var prevUrl: String?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case count
        case pages
        case nextUrl = "next"
        case prevUrl = "prev"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(pages, forKey: .pages)
        try container.encodeIfPresent(nextUrl, forKey: .nextUrl)
        try container.encodeIfPresent(prevUrl, forKey: .prevUrl)
    }
}
