//
//  VitesseApp.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    // Single instance of your container
    let dependenciesContainer = NetworkDependenciesContainer()

    var body: some Scene {
        WindowGroup {
            Login(authenticationRepository: dependenciesContainer.authenticationRepository)
                .environment(\.dependenciesContainer, dependenciesContainer)
        }
    }
}

extension EnvironmentValues {
    // Fake singleton
    private static let staticDependenciesContainer = NetworkDependenciesContainer()
    
    @Entry var dependenciesContainer = staticDependenciesContainer
}
