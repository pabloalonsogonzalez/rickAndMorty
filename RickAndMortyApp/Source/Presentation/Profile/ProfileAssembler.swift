//
//  ProfileAssembler.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation

protocol ProfileAssembler {
    static func resolve() -> ProfileView
    static func resolve() -> ProfileViewModel
}

struct DefaultProfileAssembler: ProfileAssembler {

    static func resolve() -> ProfileView {
        ProfileView(viewModel: resolve())
    }
    static func resolve() -> ProfileViewModel {
        ProfileViewModel()
    }
}
