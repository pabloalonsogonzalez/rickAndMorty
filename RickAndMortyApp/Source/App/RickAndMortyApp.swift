//
//  RickAndMortyApp.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            RickAndMortyApp.main()
        } else {
            TestApp.main()
        }
    }
}


struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

struct RickAndMortyApp: App {
    @State var presentedScreen = PresentedScreen()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(presentedScreen)
        }
    }
}
