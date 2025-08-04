//
//  CandidateDetailsStaticViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 04/08/2025.
//
import SwiftUI

final class CandidateDetailsStaticViewModel: ObservableObject {
    @Published private var candidate: CandidateDTO

    @Environment(\.dependenciesContainer) private var dependenciesContainer

    init(candidate: CandidateDTO) {
        self.candidate = candidate
    }

    var isAdmin: Bool {
        dependenciesContainer.authenticationService.authenticationManager.tokenAdmin.isAdmin
    }

    var displayName: String {
        candidate.displayedName
    }

    func toggleFavorite() async throws {
        try await dependenciesContainer.candidateService.updateFavorite(candidate: candidate)
    }
}
