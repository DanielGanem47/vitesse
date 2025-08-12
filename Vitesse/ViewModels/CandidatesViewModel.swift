//
//  CandidatesViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation
import SwiftUI

class CandidatesViewModel: ObservableObject {
    private var dependenciesContainer: NetworkDependenciesContainer?
    private var candidates: [NetworkCandidate] = []
    var candidatesToDisplay: [NetworkCandidate] = []
    var selectedCandidates = Set<UUID>()
    
    func initWith(dependenciesContainer: NetworkDependenciesContainer) {
        self.dependenciesContainer = dependenciesContainer
    }
    
#if DEBUG
    private static let defaultCandidates = [
        NetworkCandidate(id: UUID(),
                         firstName: "Daniel 1",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true),
        NetworkCandidate(id: UUID(),
                         firstName: "Daniel 2",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true),
        NetworkCandidate(id: UUID(),
                         firstName: "Daniel 3",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
        NetworkCandidate(id: UUID(),
                         firstName: "Daniel 4",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
        NetworkCandidate(id: UUID(),
                         firstName: "Daniel 5",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
        NetworkCandidate(id: UUID(),
                         firstName: "Daniel 6",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true)
    ]
    
    // MARK: Init table
    func initTable() async throws {
        guard let dependenciesContainer else {
            fatalError("Failed to inject dependencies container")
        }
        
        try await dependenciesContainer.candidateService.initTable(candidates: Self.defaultCandidates)
    }
#endif
    
    // MARK: Load table
    @MainActor func loadTable() async throws {
        guard let dependenciesContainer else {
            fatalError("Failed to inject dependencies container")
        }
        
        candidates = try await dependenciesContainer.candidateService.getAll()
        candidatesToDisplay = candidates
    }
    
    // MARK: Favorites
    func filterByFavorites() {
        candidatesToDisplay.removeAll()
        candidatesToDisplay = candidates.filter { $0.isFavorite }
    }
    
    func resetFilteredCandidates() {
        candidatesToDisplay = candidates
    }
    
    // MARK: Delete
    func deleteSelectedCandidates() async throws {
        for candidateId in selectedCandidates {
            try await dependenciesContainer?.candidateService.delete(candidateId: candidateId)
        }
        
        try await loadTable()
    }
    
    func selectCandidate(candidateId: UUID, isSelected: Bool) {
        if isSelected {
            selectedCandidates.insert(candidateId)
        } else {
            selectedCandidates.remove(candidateId)
        }
    }
    
    // MARK: Functions
    func getDisplayedNameFor(networkCandidate: NetworkCandidate) -> String {
        return "\(networkCandidate.firstName) \(networkCandidate.lastName.first?.uppercased() ?? "")."
    }
    
    func getCandidate(candidateId: UUID) async -> NetworkCandidate {
        return candidatesToDisplay.filter { $0.id == candidateId }.first!
    }
    
    func update(candidate: NetworkCandidate) async throws {
        guard let dependenciesContainer else {
            fatalError("Failed to inject dependencies container")
        }
        
        do {
            var _ = try await dependenciesContainer.candidateService.update(candidate: candidate)
            try await loadTable()
        } catch {
            handle(error: error)
        }
    }
    
    func toggleFavoriteFor(candidate: NetworkCandidate) async throws {
        guard let dependenciesContainer else {
            fatalError("Failed to inject dependencies container")
        }
        
        try await dependenciesContainer.candidateService.updateFavorite(candidate: candidate)
        let oldCandidate = candidates.filter { $0.id == candidate.id }.first
        oldCandidate?.isFavorite = candidate.isFavorite
    }

    // MARK: Errors handling
    private func handle(error: Error) {
        
    }
}

