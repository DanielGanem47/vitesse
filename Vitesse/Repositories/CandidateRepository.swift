enum CandidateRepositoryError {
    case unknown
}

final class CandidateRepository {
    var candidateService: NetworkCandidateService
    
    private(set) var candidates: [CandidateDTO] = []
    
    // MARK: - Initializers
    init(candidateService: NetworkCandidateService = NetworkCandidateService()) {
        self.candidateService = candidateService
    }
    
    // MARK: - Functions
    #if DEBUG
    func initTable(candidates: [CandidateDTO]) async throws {
        try await candidateService.initTable(candidates: candidates)
    }
    #endif
    
    func fetchCandidates() async throws {
        candidates = try await candidateService.getAll()
    }
    
    func get(candidateId: String) async throws -> CandidateDTO {
        let candidate = try await candidateService.get(candidateId: candidateId)
        
        return candidate
    }
    
    func update(candidate: CandidateDTO) async throws {
        let _ = try await candidateService.update(candidate: candidate)
        
        try await fetchCandidates()
    }
    
    func delete(candidate: CandidateDTO) async throws {
        if try await candidateService.delete(candidate: candidate) {
            try await fetchCandidates()
        }
    }
    
    func updateFavorite(candidate: CandidateDTO) async throws {
        try await candidateService.updateFavorite(candidate: candidate)
    }
}
