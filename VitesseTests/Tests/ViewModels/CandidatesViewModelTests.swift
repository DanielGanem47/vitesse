//
//  CandidatesViewModelTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
import Testing
@testable import Vitesse

@Suite struct CandidatesViewModelTests {
    @Test func testDoSomething() async throws {
        let spyContainer = SpyCustomDependenciesContainer()

        // Given
        let element = CandidatesViewModel(dependenciesContainer: spyContainer)

        // When
        try await element.deleteSelectedCandidates()

        // Then
        #expect((spyContainer.candidatesRepository as? SpyCandidatesRepository)!.hasCalledDeleteCandidate == true)
    }
}
