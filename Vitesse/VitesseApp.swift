//
//  VitesseApp.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    let repo = AuthenticationRepository()

    var body: some Scene {
        WindowGroup {
            Login(authenticationRepository: repo)
        }
    }
}

extension EnvironmentValues {
    // Fake singleton
    private static let staticDependenciesContainer = NetworkDependenciesContainer()
    
    @Entry var dependenciesContainer = staticDependenciesContainer
}
