import Foundation

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
    
    func delete(candidateId: UUID) async throws {
        try await candidateService.delete(candidateId: candidateId)
    }
    
    func updateFavorite(candidate: CandidateDTO) async throws {
        try await candidateService.updateFavorite(candidate: candidate)
    }
}
