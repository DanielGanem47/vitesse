//
//  CandidatesViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation
import SwiftUI

class CandidatesViewModel: ObservableObject {
    private let executeDataRequestCandidate: (URLRequest) async throws -> (Data, URLResponse)

    @Published var candidates: Candidates = Candidates(list: [
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
    ])
    @Published var filteredCandidates: Candidates = Candidates(list: [])

    var tokenAdmin: TokenAdminDTO = TokenAdminDTO(token: "", isAdmin: false)
    
    init (executeDataRequestCandidate: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)) {
        self.executeDataRequestCandidate = executeDataRequestCandidate
        filteredCandidates.list = candidates.list
    }
    
    // MARK: Init table
    @MainActor func initTable() async throws {
        for candidate in candidates.list {
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
    
    // MARK: Load table
    @MainActor func loadTable() async throws {
        guard let url = URL(string: "http://localhost:8080/candidate") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .GET,
            parameters: nil,
            headers: ["Authorization" : "Bearer \(tokenAdmin.token)"]
        )
        
        let (data, _) = try await executeDataRequestCandidate(request)
        
        let JSON = try JSONDecoder().decode([CandidateDTO].self,
                                            from: data)
        
        candidates.list = JSON
    }
    
    // MARK: Favorites
    func filterByFavorites() {
        filteredCandidates.list.removeAll()
        filteredCandidates.list = candidates.list.filter { $0.isFavorite }
    }
    
    func resetFilteredCandidates() {
        filteredCandidates.list = candidates.list
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
        
        if let index = candidates.list.firstIndex(where: { $0.id == candidate.id }) {
            candidates.list[index] = JSON
        }
    }
    
    // MARK: Delete
    func deleteSelectedCandidates() async throws {
        for candidate in candidates.list where candidate.isSelected {
            if try await !deleteCandidate(candidate: candidate) {
                print("Cannot delete candidate \(candidate.displayedName)")
            }
        }
        candidates.list.removeAll(where: { $0.isSelected })
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

