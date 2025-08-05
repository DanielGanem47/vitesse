//
//  CandidateServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI
@testable import Vitesse

struct CandidateServiceTests {
    @Environment(\.testDependenciesContainer) private var testDependenciesContainer

    @Test func getAll() async throws {
        let candidates = try await testDependenciesContainer.candidateService.getAll()
        #expect(candidates.count == 6)
    }

    @Test(arguments: ["1"]) func get(id: String) async throws {
        let candidate = try await testDependenciesContainer.candidateService.get(candidateId: id)
        #expect(candidate.firstName == "Daniel 1")
    }
}
