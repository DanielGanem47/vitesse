//
//  CandidatesRepositoryTests.swift
//  Vitesse
//
//  Created by daniel ganem on 15/08/2025.
//

import Foundation

final class CandidatesRepositoryTests: TestCandidateService, ObservableObject {
    @Published private(set) var candidates: [CandidateDTO] = []

    private let service: any CandidateService

    init(service: any CandidateService = TestCandidateService()) {
        self.service = service
    }

    // MARK: - Functions
    #if DEBUG
    func initTable(candidates: [CandidateDTO]) async throws {
        try await service.initTable(candidates: candidates)
    }
    #endif

    func getAll() async throws -> [CandidateDTO] {
        return try await service.getAll()
    }
    
    func get(candidateId: String) async throws -> CandidateDTO {
        return try await service.get(candidateId: candidateId)
    }
    
    func refresh() async {
        do {
            self.candidates = try await service.getAll()
        } catch {

        }
    }

    func delete(candidateId: UUID) async throws {
        try await service.delete(candidateId: candidateId)
    }

    func update(candidate: CandidateDTO) async throws -> CandidateDTO {
        try await service.update(candidate: candidate)
    }

    func updateFavorite(candidate: CandidateDTO) async throws {
        try await service.updateFavorite(candidate: candidate)
    }
}
