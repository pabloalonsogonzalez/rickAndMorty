//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//
import Foundation

struct Character: Hashable {
    enum Status: String {
        case alive
        case dead
        case unknown
    }
    var id: Int
    var name: String
    var status: Status
    var species: String
    var gender: String
    var origin: SimpleLocation
    var location: SimpleLocation
    var imageUrl: String
    var episodesUrls: [String]
    var created: Date
}

struct SimpleLocation: Hashable {
    var name: String
    var url: String
}
