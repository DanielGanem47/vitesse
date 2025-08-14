//
//  CandidatesViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation
import SwiftUI

class CandidatesViewModel: ObservableObject {

    private var dependenciesContainer: any CustomDependenciesContainer

    @Published var candidates: [CandidateDTO] = []
    @Published var candidatesToDisplay: [CandidateDTO] = []
    @Published var selectedCandidates = Set<UUID>()

    init(dependenciesContainer: any CustomDependenciesContainer) {
        self.dependenciesContainer = dependenciesContainer
    }

#if DEBUG
    private static let defaultCandidates = [
        CandidateDTO(id: UUID(),
                         firstName: "Daniel 1",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true),
        CandidateDTO(id: UUID(),
                         firstName: "Daniel 2",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true),
        CandidateDTO(id: UUID(),
                         firstName: "Daniel 3",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
        CandidateDTO(id: UUID(),
                         firstName: "Daniel 4",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
        CandidateDTO(id: UUID(),
                         firstName: "Daniel 5",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
        CandidateDTO(id: UUID(),
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
        try await dependenciesContainer.candidatesRepository.initTable(candidates: Self.defaultCandidates)
    }
#endif
    
    // MARK: Load table
    @MainActor func loadTable() async {
        await dependenciesContainer.candidatesRepository.refresh()

        candidates = dependenciesContainer.candidatesRepository.candidates
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
            try await dependenciesContainer.candidatesRepository.delete(candidateId: candidateId)
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
    func getDisplayedNameFor(networkCandidate: CandidateDTO) -> String {
        return "\(networkCandidate.firstName) \(networkCandidate.lastName.first?.uppercased() ?? "")."
    }
    
    func getCandidate(candidateId: UUID) async -> CandidateDTO? {
        candidatesToDisplay.filter { $0.id == candidateId }.first
    }
    
    func update(candidate: CandidateDTO) async throws {
        do {
            var _ = try await dependenciesContainer.candidatesRepository.update(candidate: candidate)
        } catch {
            handle(error: error)
        }
    }
    
    func toggleFavoriteFor(candidate: CandidateDTO) async throws {
        let oldCandidate = candidates.filter { $0.id == candidate.id }.first
        oldCandidate?.isFavorite = candidate.isFavorite

        try await dependenciesContainer.candidatesRepository.updateFavorite(candidate: candidate)
    }

    // MARK: Errors handling
    private func handle(error: Error) {
        
    }

    func refreshList() {
        objectWillChange.send()
    }
}

