//
//  PaginatedResultDTOBuilder.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez on 21/10/24.
//


import Foundation
@testable import RickAndMortyApp

class PaginatedResultDTOBuilder<T: Codable>: BaseDTOBuilder {
    
    public var results: [T]
    public var info: PaginationInfoDTO = PaginationInfoDTOBuilder().build()
    
    init(results: [T]) {
        self.results = results
    }
    
    func build() -> PaginatedResultDTO<T> {
        return PaginatedResultDTO(info: info,
                                  results: results)
    }
    
    func info(_ info: PaginationInfoDTO) -> PaginatedResultDTOBuilder {
        self.info = info
        return self
    }
    
}
