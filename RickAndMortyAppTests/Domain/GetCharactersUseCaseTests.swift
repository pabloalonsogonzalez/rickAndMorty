//
//  GetCharactersUseCaseTests.swift
//  RickAndMortyAppTests
//
//  Created by Pablo Alonso Gonzalez.
//

import XCTest
@testable import RickAndMortyApp
import Combine

final class GetCharactersUseCaseTests: XCTestCase {
    
    private var sut: GetCharactersUseCase!
    private var stub: RickAndMortyRepositoryStub!
    private let cancelBag = CancelBag()

    override func setUp() {
        stub = RickAndMortyRepositoryStub()
        sut = GetCharactersUseCase(repository: stub)
    }
    
    func testGetCharactersByUrl() {
        // Given
        let expectation = XCTestExpectation(description: "GetCharacters")
        let nextUrl = "nextURL"
        let previousResult = PaginatedResult<Character>(paginationInfo: PaginationInfo(count: 1,
                                                                                       pages: 1,
                                                                                       nextUrl: nextUrl),
                                                        results: [])
        let errorTracker = ErrorTracker()
        errorTracker
            .sink { _ in
                XCTFail()
            }
            .store(in: cancelBag)
        
        // When
        sut.execute(GetCharactersUseCase.Query(previousResult: previousResult))
            .trackError(errorTracker)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        // Then
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(stub.getCharactersByUrlCallCount == 1)
        XCTAssertTrue(stub.getCharactersCallCount == 0)
    }
    
    func testGetFilteredCharacters() {
        // Given
        let expectation = XCTestExpectation(description: "GetCharacters")
        let errorTracker = ErrorTracker()
        errorTracker
            .sink { _ in
                XCTFail()
            }
            .store(in: cancelBag)
        
        // When
        sut.execute(GetCharactersUseCase.Query(name: "Name",
                                               status: .alive))
            .trackError(errorTracker)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: cancelBag)
        
        // Then
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(stub.getCharactersCallCount == 1)
        XCTAssertTrue(stub.getCharactersByUrlCallCount == 0)
    }

}
