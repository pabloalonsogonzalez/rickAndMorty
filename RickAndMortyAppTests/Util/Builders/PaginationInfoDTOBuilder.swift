//
//  PaginationInfoDTOBuilder.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez on 21/10/24.
//


import Foundation
@testable import RickAndMortyApp

class PaginationInfoDTOBuilder: BaseDTOBuilder {
    
    public var count: Int = 100
    public var pages: Int = 3
    public var nextUrl: String? = "nextURL"
    public var prevUrl: String? = "prevURL"
    
    func build() -> PaginationInfoDTO {
        return PaginationInfoDTO(count: count,
                                 pages: pages,
                                 nextUrl: nextUrl,
                                 prevUrl: prevUrl)
    }
    
    func count(_ count: Int) -> PaginationInfoDTOBuilder {
        self.count = count
        return self
    }
    
    func pages(_ pages: Int) -> PaginationInfoDTOBuilder {
        self.pages = pages
        return self
    }
    
    func nextUrl(_ nextUrl: String?) -> PaginationInfoDTOBuilder {
        self.nextUrl = nextUrl
        return self
    }
    
    func prevUrl(_ prevUrl: String?) -> PaginationInfoDTOBuilder {
        self.prevUrl = prevUrl
        return self
    }
    
}
