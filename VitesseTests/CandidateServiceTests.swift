//
//  CandidateServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI
@testable import Vitesse

@Suite
struct CandidateServiceTests {
    private var service = TestCandidateService()

    @Test func getAll() async throws {
        let candidates = try await service.getAll()
        #expect(candidates.count == 6)
    }

    @Test(arguments: ["1"]) func get(id: String) async throws {
        let candidate = try await service.get(candidateId: id)
        #expect(candidate.firstName == "Daniel 1")
    }
    
    @Test(arguments: [CandidateDTO(id: UUID(),
                                   firstName: "Daniel 1",
                                   lastName: "Ganem",
                                   phone: "06 37 93 62 65",
                                   email: "daniel.ganem@icloud.com",
                                   linkedin_url: "www.linkedin.com",
                                   note: "tres bon eleve",
                                   isFavorite: true)]) func update(candidate: CandidateDTO) async throws {
        let result = try await service.update(candidate: candidate)
        #exoect(result..firstName == "Daniel 1")
    }
    
    @Test(arguments: [UUID()]) func delete(candidateId: UUID) async throws {
        let result = try await service.delete(candidateId: candidateId)
        #expect (result == false)
    }
    
    @Test(arguments: [CandidateDTO(id: UUID(),
                                   firstName: "Daniel 1",
                                   lastName: "Ganem",
                                   phone: "06 37 93 62 65",
                                   email: "daniel.ganem@icloud.com",
                                   linkedin_url: "www.linkedin.com",
                                   note: "tres bon eleve",
                                   isFavorite: true)]) func updateFavorite(candidate: CandidateDTO) async throws {
        let result = try await service.updateFavorite(candidate: candidate)
        #exepect (result.isFavorite == true)
    }
}
