//
//  UseCase.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import Combine

protocol UseCase {

    associatedtype T
    associatedtype Query: UseCaseQuery

    func buildObservable(_ query: Query) -> Observable<T>

}

extension UseCase {

    func execute(_ query: Query = Query()) -> Observable<T> {
        buildObservable(query)
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

}

protocol UseCaseQuery {
    init()
}

extension UseCaseQuery {
    init() {
        self.init()
    }
}
