
enum CandidateRepositoryError {
    case unknown
}

final class CandidateRepository {

    private let candidateService: NetworkCandidateService

    private(set) var candidates: [CandidateDTO] = []

    // MARK: - Initializers

    init(candidateService: NetworkCandidateService = NetworkCandidateService()) {
        self.candidateService = candidateService
    }

    // MARK: - Functions

    func fetchCandidates() async throws {
        candidates = try await candidateService.getAll()
    }

    func update(candidate: CandidateDTO) async throws {
        let _ = try await candidateService.update(candidate: candidate)
        
        try await fetchCandidates()
    }

    func delete(candidate: CandidateDTO) async throws {
        try await candidateService.delete(candidate: candidate)

        try await fetchCandidates()
    }
}
