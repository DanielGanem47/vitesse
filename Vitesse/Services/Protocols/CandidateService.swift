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
    func initTable(candidates: [CandidateDTO]) async throws
#endif
    
    func getAll() async throws -> [CandidateDTO]
    func get(candidateId: String) async throws -> CandidateDTO
    func update(candidate: CandidateDTO) async throws -> CandidateDTO
    func delete(candidateId: UUID) async throws
    func updateFavorite(candidate: CandidateDTO) async throws
}

