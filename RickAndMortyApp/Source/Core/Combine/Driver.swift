//
//  Driver.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import Combine
import Foundation

typealias Driver<T> = AnyPublisher<T, Never>

extension Publisher {
    
    func asDriver() -> Driver<Output> {
        self.catch { _ in Empty() }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> Driver<Output> {
        Just(output)
            .eraseToAnyPublisher()
    }

    static func empty() -> Driver<Output> {
        Empty().eraseToAnyPublisher()
    }

}

