//
//  SimpleLocationDTOBuilder.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez on 21/10/24.
//


import Foundation
@testable import RickAndMortyApp

class SimpleLocationDTOBuilder: BaseDTOBuilder {
    
    public var name: String = "Earth"
    public var url: String = "url"
    
    func build() -> SimpleLocationDTO {
        return SimpleLocationDTO(name: name, url: url)
    }
    
    func name(_ name: String) -> SimpleLocationDTOBuilder {
        self.name = name
        
        return self
    }
    
    func url(_ url: String) -> SimpleLocationDTOBuilder {
        self.url = url
        
        return self
    }
    
}
