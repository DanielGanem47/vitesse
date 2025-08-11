//
//  CandidateService.swift
//  Vitesse
//
//  Created by daniel ganem on 04/08/2025.
//

import Foundation

enum CandidateServiceError: Error {
    case notImplemented
    case notAuthenticated
    case candidateNotDeleted
}

protocol CandidateService {
#if DEBUG
    func initTable(candidates: [NetworkCandidate]) async throws
#endif
    
    func getAll() async throws -> [NetworkCandidate]
    func get(candidateId: String) async throws -> NetworkCandidate
    func update(candidate: NetworkCandidate) async throws -> NetworkCandidate
    func delete(candidateId: UUID) async throws
    func updateFavorite(candidate: NetworkCandidate) async throws
}

