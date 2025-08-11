//
//  VitesseApp.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

@main
struct VitesseApp: App {
    var body: some Scene {
        WindowGroup {
            Login()
        }
    }
}

extension EnvironmentValues {
    // Fake singleton
    private static let staticDependenciesContainer = NetworkDependenciesContainer()
    
    @Entry var dependenciesContainer = staticDependenciesContainer
}
