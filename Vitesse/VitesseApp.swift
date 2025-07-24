//
//  VitesseApp.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import SwiftUI

@main
struct VitesseApp: App {

    @Environment(\.dependenciesContainer)
    private var dependenciesContainer

    @ObservedObject
    var loginViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            if !loginViewModel.isLogged {
                LoginView(dependenciesContainer: dependenciesContainer, loginViewModel: loginViewModel)
            } else {
                NavigationStack {
                    CandidatesList(loginViewModel: loginViewModel)
                }
            }
        }
    }
}

extension EnvironmentValues {

    // Fake singleton
    private static let staticDependenciesContainer = DependenciesContainer()

    @Entry
    var dependenciesContainer = staticDependenciesContainer
}
