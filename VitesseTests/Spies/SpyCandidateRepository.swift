//
//  SpyCandidateRepository.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
@testable import Vitesse

class SpyCandidatesRepository: CandidatesRepository {
    var HasCalledRefresh = false
    var hasCalledDeleteCandidate = false
    var hasCalledUpdate = false
    var hasCalledUpdateFavorite = false

    override func delete(candidateId: UUID) async throws {
        hasCalledDeleteCandidate = true
    }
    
    override func refresh() async {
        HasCalledRefresh = true
    }
    
    override func update(candidate: CandidateDTO) async throws -> CandidateDTO {
        hasCalledUpdate = true
        return CandidateDTO(id: UUID(),
                            firstName: "",
                            lastName: "",
                            phone: "",
                            email: "",
                            linkedin_url: "",
                            note: "",
                            isFavorite: true)
    }
    
    override func updateFavorite(candidate: CandidateDTO) async throws {
        hasCalledUpdateFavorite = true
    }
}
