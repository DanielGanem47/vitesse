//
//  CandidatesViewModelTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
import Testing
@testable import Vitesse

@Suite
struct CandidatesViewModelTests {
    @Test func testDeleteSelectedCandidates() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        model.selectCandidate(candidateId: UUID(),
                              isSelected: true)
        try await model.deleteSelectedCandidates()
        
        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledDeleteCandidate == true && model.candidates.count == 0)
    }
    
    @Test func testLoadTable() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        try await model.loadTable()
        
        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.HasCalledRefresh == true && model.candidates.count == 0)
    }
    
    @Test func testFiterByFavorites() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        model.filterByFavorites()
        
        // Then
        #expect(model.candidates.count == 0)
    }
    
    @Test func testResetFilteredCandidates() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        model.resetFilteredCandidates()
        
        // Then
        #expect(model.candidatesToDisplay.count == 0)
    }
    
    @Test func testSelectCandidate() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        model.selectCandidate(candidateId: UUID(),
                              isSelected: true)
        
        // Then
        #expect(model.selectedCandidates.count == 1)
    }
    
    @Test func testGetDisplayNamed() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        let displayedName = model.getDisplayedNameFor(networkCandidate: CandidateDTO(id: UUID(),
                                                                                      firstName: "Daniel",
                                                                                      lastName: "Ganem",
                                                                                      phone: "03 37 93 62 65",
                                                                                      email: "daniel.ganem@icloud.com",
                                                                                      linkedin_url: "www.linkedin.com",
                                                                                      note: "Tres bon eleve",
                                                                                      isFavorite: true))
        
        // Then
        #expect(displayedName == "Daniel G.")
    }
    
    @Test func testGetCandidate() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        let candidate = await model.getCandidate(candidateId: UUID())
        
        // Then
        #expect(candidate == nil)
    }
    
    @Test func testUpdate() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)
        
        // When
        try await model.update(candidate: CandidateDTO(id: UUID(),
                                                       firstName: "Daniel",
                                                       lastName: "Ganem",
                                                       phone: "03 37 93 62 65",
                                                       email: "daniel.ganem@icloud.com",
                                                       linkedin_url: "www.linkedin.com",
                                                       note: "Tres bon eleve",
                                                       isFavorite: true))
        
        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledUpdate == true)
    }
    
    @Test func testUpdateFavorite() async throws {
        // Given
        let spyContainer = SpyCustomDependenciesContainer()
        let model = CandidatesViewModel(dependenciesContainer: spyContainer)

        // When
        try await model.toggleFavoriteFor(candidate: CandidateDTO(id: UUID(),
                                                                  firstName: "Daniel",
                                                                  lastName: "Ganem",
                                                                  phone: "03 37 93 62 65",
                                                                  email: "daniel.ganem@icloud.com",
                                                                  linkedin_url: "www.linkedin.com",
                                                                  note: "Tres bon eleve",
                                                                  isFavorite: true))

        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledUpdateFavorite == true)
    }
}
