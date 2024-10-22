//
//  PaginationInfo.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

struct PaginatedResult<T> {
    var paginationInfo: PaginationInfo
    var results: [T]
}

struct PaginationInfo {
    var count: Int
    var pages: Int
    var nextUrl: String?
    var prevUrl: String?
}
