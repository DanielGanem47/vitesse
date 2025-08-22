//
//  CandidatesViewModelTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
import Testing
@testable import Vitesse

@Suite(.serialized)
struct CandidatesViewModelTests {
    @Test func testDelete() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        
        // When
        try await spyContainer.candidatesRepository.delete(candidateId: UUID())
        
        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledDeleteCandidate == true)
    }
    
    @Test func testRefresh() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        
        // When
        await spyContainer.candidatesRepository.refresh()
        
        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.HasCalledRefresh == true)
    }
    
    @Test func testUpdate() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        
        // When
        let _ = try await spyContainer.candidatesRepository.update(candidate: CandidateDTO(id: UUID(),
                                                                                           firstName: "",
                                                                                           lastName: "",
                                                                                           phone: "",
                                                                                           email: "",
                                                                                           linkedin_url: "",
                                                                                           note: "",
                                                                                           isFavorite: true))
        
        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledUpdate == true)
    }
    
    @Test func testUpdateFavorite() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()

        // When
        try await spyContainer.candidatesRepository.updateFavorite(candidate: CandidateDTO(id: UUID(),
                                                                                           firstName: "",
                                                                                           lastName: "",
                                                                                           phone: "",
                                                                                           email: "",
                                                                                           linkedin_url: "",
                                                                                           note: "",
                                                                                           isFavorite: true))

        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledUpdateFavorite == true)
    }
}
