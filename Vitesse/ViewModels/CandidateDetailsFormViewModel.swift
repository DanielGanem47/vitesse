//
//  CandidateDetailsFormViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 01/08/2025.
//

import SwiftUI

final class CandidateDetailsFormViewModel {
    @Environment(\.dependenciesContainer) private var dependenciesContainer

   func update(candidate: CandidateDTO) async throws {
       try await dependenciesContainer.candidateService.update(candidate: candidate)
    }
}
