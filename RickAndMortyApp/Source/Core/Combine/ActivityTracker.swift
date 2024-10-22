//
//  ActivityTracker.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import Combine
import UIKit

public typealias ActivityTracker = CurrentValueSubject<Bool, Never>

extension Publisher {
    
    public func trackActivity(_ activityTracker: ActivityTracker) -> AnyPublisher<Output, Failure> {
        handleEvents(receiveSubscription: { _ in
            activityTracker.send(true)
        }, receiveCompletion: { _ in
            activityTracker.send(false)
        })
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
