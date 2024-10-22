//
//  ErrorTracker.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import Combine
import Foundation

public typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher {
    
    func trackError(_ errorTracker: ErrorTracker) -> Driver<Output> {
        handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
            .asDriver()
    }
}
