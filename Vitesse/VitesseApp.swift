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
    private static let staticDependenciesContainer = DependenciesContainer(candidateService: <#T##NetworkCandidateService#>, candidateRepository: <#T##CandidateRepository#>)
}
