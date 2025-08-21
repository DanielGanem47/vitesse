import Foundation
@testable import Vitesse

class SpyCandidatesRepository: CandidatesRepository {

    var hasCalledDeleteCandidate = false

    override func delete(candidateId: UUID) async throws {
        hasCalledDeleteCandidate = true
    }
}
