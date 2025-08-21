//
//  CandidatesRepository.swift
//  Vitesse
//
//  Created by daniel ganem on 15/08/2025.
//

import Foundation

class MockCandidatesRepository: CandidatesRepository {

    var hasCalledDeleteCandidate = false

    override func delete(candidateId: UUID) async throws {
        hasCalledDeleteCandidate = true
    }
}

class CandidatesRepository: ObservableObject {
    @Published private(set) var candidates: [CandidateDTO] = []

    private let service: any CandidateService

    init(service: any CandidateService = NetworkCandidateService()) {
        self.service = service
    }

    // MARK: - Functions
    #if DEBUG
    func initTable(candidates: [CandidateDTO]) async throws {
        try await service.initTable(candidates: candidates)
    }
    #endif

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
