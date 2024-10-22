//
//  RickAndMortyRepositoryTests.swift
//  RickAndMortyAppTests
//
//  Created by Pablo Alonso Gonzalez.
//

import XCTest
@testable import RickAndMortyApp
import OHHTTPStubsSwift
import OHHTTPStubs
import Combine

final class RickAndMortyRepositoryTests: XCTestCase {
    
    private var sut: RickAndMortyRepository!
    private let cancelBag = CancelBag()

    override func setUp() {
        sut = DefaultRickAndMortyDataAssembler.resolve()
    }
    
    func testGetCharactersSuccess() {
        // Given
        let characterDTOBuilder = CharacterDTOBuilder()
        let paginatedResultDTOBuilder = PaginatedResultDTOBuilder<CharacterDTO>(results: [characterDTOBuilder.build()])
        stub(condition: pathStartsWith("/api/character")) { request in
            return HTTPStubsResponse(data: paginatedResultDTOBuilder.buildData(),
                                     statusCode: 200,
                                     headers: [:])
        }
        let expectation = XCTestExpectation(description: "GetCharacters")
        let errorTracker = ErrorTracker()
        errorTracker
            .sink { _ in
                XCTFail()
            }
            .store(in: cancelBag)
        
        // When
        sut.getCharacters(name: nil, status: nil)
            .trackError(errorTracker)
            .sink { result in
                if result.results.map(\.id) == paginatedResultDTOBuilder.build().results.map(\.id) {
                    expectation.fulfill()
                }
            }
            .store(in: cancelBag)
        
        // Then
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetCharactersError() {
        // Given
        stub(condition: pathStartsWith("/api/character")) { request in
            return HTTPStubsResponse(data: Data(),
                                     statusCode: 500,
                                     headers: [:])
        }
        let expectation = XCTestExpectation(description: "Error")
        let errorTracker = ErrorTracker()
        errorTracker
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        // When
        sut.getCharacters(name: nil, status: nil)
            .trackError(errorTracker)
            .sink { _ in
                XCTFail()
            }
            .store(in: cancelBag)
        
        // Then
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetCharactersNotFoundError() {
        // Given
        stub(condition: pathStartsWith("/api/character")) { request in
            return HTTPStubsResponse(data: Data(),
                                     statusCode: 404,
                                     headers: [:])
        }
        let expectation = XCTestExpectation(description: "Error")
        let errorTracker = ErrorTracker()
        errorTracker
            .sink {
                if ($0 as? RickAndMortyError) == .noCharactersFound {
                    expectation.fulfill()
                }
            }
            .store(in: cancelBag)
        
        // When
        sut.getCharacters(name: nil, status: nil)
            .trackError(errorTracker)
            .sink { _ in
                XCTFail()
            }
            .store(in: cancelBag)
        
        // Then
        wait(for: [expectation], timeout: 10)
    }
    
    //...

}
