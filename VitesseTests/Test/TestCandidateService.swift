import Foundation

class TestCandidateService: CandidateService {
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }
    
    #if DEBUG
    func initTable(candidates: [CandidateDTO]) async throws {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        for candidate in candidates {
            candidate.id = UUID()
            candidate.isFavorite = false
        }
    }
    #endif
    
    func getAll() async throws -> [CandidateDTO] {
        return [
            CandidateDTO(id: UUID(),
                         firstName: "Daniel 1",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true),
            CandidateDTO(id: UUID(),
                         firstName: "Daniel 2",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true),
            CandidateDTO(id: UUID(),
                         firstName: "Daniel 3",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
            CandidateDTO(id: UUID(),
                         firstName: "Daniel 4",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
            CandidateDTO(id: UUID(),
                         firstName: "Daniel 5",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: false),
            CandidateDTO(id: UUID(),
                         firstName: "Daniel 6",
                         lastName: "Ganem",
                         phone: "06 37 93 62 65",
                         email: "daniel.ganem@icloud.com",
                         linkedin_url: "www.linkedin.com",
                         note: "tres bon eleve",
                         isFavorite: true)
        ]
    }
    
    func get(candidateId: String) async throws -> CandidateDTO {
        return CandidateDTO(id: UUID(),
                            firstName: "Daniel 1",
                            lastName: "Ganem",
                            phone: "06 37 93 62 65",
                            email: "daniel.ganem@icloud.com",
                            linkedin_url: "www.linkedin.com",
                            note: "tres bon eleve",
                            isFavorite: true)
    }
    
    func update(candidate: CandidateDTO) async throws -> CandidateDTO {
        return CandidateDTO(id: UUID(),
                            firstName: "Daniel 1",
                            lastName: "Ganem",
                            phone: "06 37 93 62 65",
                            email: "daniel.ganem@icloud.com",
                            linkedin_url: "www.linkedin.com",
                            note: "tres bon eleve",
                            isFavorite: true)
    }
    
    func delete(candidateId: UUID) async throws {
    }
    
    func updateFavorite(candidate: CandidateDTO) async throws {
    }
}
