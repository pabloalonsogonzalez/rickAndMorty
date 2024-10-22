//
//  BaseDTOBuilder.swift
//  OrangeBank
//
//  Created by Pablo Alonso Gonzalez on 26/11/2018.
//  Copyright © 2018 OrangeBank. All rights reserved.
//

import Foundation
@testable import RickAndMortyApp

protocol BaseDTOBuilder {
    
    associatedtype T : Encodable
    
    func build() -> T
    func buildData() -> Data
    
}

extension BaseDTOBuilder {
    
    func buildData() -> Data {
        try! JSONEncoder().encode(build())
    }
}
