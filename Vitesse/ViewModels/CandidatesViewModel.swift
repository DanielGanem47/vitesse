//
//  CandidatesViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation
import SwiftUI

class CandidatesViewModel: ObservableObject {

    private var dependenciesContainer: DependenciesContainer?

    private let executeDataRequestCandidate: (URLRequest) async throws -> (Data, URLResponse)

    private var candidates: [CandidateDTO] = []

    @Published
    var candidatesToDisplay: [CandidateDTO] = []

    var tokenAdmin: TokenAdminDTO = TokenAdminDTO(token: "", isAdmin: false)
    
    init(executeDataRequestCandidate: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequestCandidate = executeDataRequestCandidate
    }

    func initWith(dependenciesContainer: DependenciesContainer) {
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
    @MainActor func initTable() async throws {
        for candidate in Self.defaultCandidates {
            guard let url = URL(string: "http://localhost:8080/candidate") else {
                throw URLError(.badURL)
            }

            let request = try URLRequest(
                url: url,
                method: .POST,
                parameters: [
                    "email": candidate.email,
                    "note": candidate.note ?? "",
                    "linkedinURL": candidate.linkedinURL ?? "",
                    "firstName": candidate.firstName,
                    "lastName": candidate.lastName,
                    "phone": candidate.phone
                ],
                headers: ["Authorization" : "Bearer \(tokenAdmin.token)"]
            )

            let (data, _) = try await executeDataRequestCandidate(request)

            let JSON = try JSONDecoder().decode(CandidateDTO.self,
                                     from: data)
            
            candidate.id = JSON.id
            candidate.isFavorite = JSON.isFavorite
        }
    }

    #endif

    // MARK: Load table
    @MainActor func loadTable() async throws {
        guard let dependenciesContainer else {
            fatalError("Failed to inject dependencies container")
        }

        try await dependenciesContainer.candidateRepository.fetchCandidates()

        candidates = dependenciesContainer.candidateRepository.candidates
        
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
    
    // MARK: Update
    func updateCandidate(candidate: CandidateDTO) async throws {
        guard let url = URL(string: "http://localhost:8080/candidate/\(candidate.id)") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .PUT,
            parameters: [
                "email": candidate.email,
                "note": candidate.note ?? "",
                "linkedinURL": candidate.linkedinURL ?? "",
                "firstName": candidate.firstName,
                "lastName": candidate.lastName,
                "phone": candidate.phone
            ],
            headers: ["Authorization" : "Bearer \(tokenAdmin.token)"]
        )

        let (data, _) = try await executeDataRequestCandidate(request)

        let JSON = try JSONDecoder().decode(CandidateDTO.self,
                                            from: data)
        
        if let index = candidates.firstIndex(where: { $0.id == candidate.id }) {
            candidates[index] = JSON
        }
    }
    
    // MARK: Delete
    func deleteSelectedCandidates() async throws {
        for candidate in candidates where candidate.isSelected {
            try await dependenciesContainer?.candidateRepository.delete(candidate: candidate)
        }

        candidates.removeAll(where: { $0.isSelected })

        filterByFavorites()
    }
    
    func deleteCandidate(candidate: CandidateDTO) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/candidate") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .DELETE,
            parameters: [
                "CandidateId": candidate.id
            ],
            headers: ["Authorization" : "Bearer \(tokenAdmin.token)"]
        )

        let (_, response) = try await executeDataRequestCandidate(request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 200
    }
}

