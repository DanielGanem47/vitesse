import Foundation

class NetworkCandidateService: CandidateService {
    private let authenticationManager: AuthenticationManager
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared, authenticationManager: AuthenticationManager = .shared) {
        self.urlSession = urlSession
        self.authenticationManager = authenticationManager
    }

    #if DEBUG
    func initTable(candidates: [CandidateDTO]) async throws {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        for candidate in candidates {
            guard let url = URL(string: "http://localhost:8080/candidate") else {
                throw URLError(.badURL)
            }

            let request = try URLRequest(
                url: url,
                method: .POST,
                parameters: [
                    "email": candidate.email,
                    "note": candidate.note ?? "",
                    "linkedinURL": candidate.linkedinURL ?? "",
                    "firstName": candidate.firstName,
                    "lastName": candidate.lastName,
                    "phone": candidate.phone
                ],
                headers: ["Authorization" : "Bearer \(authenticationToken)"]
            )

            let (data, _) = try await urlSession.data(for: request)
            let JSON = try JSONDecoder().decode(NetworkCandidate.self,
                                                from: data)
            
            candidate.id = JSON.id
            candidate.isFavorite = JSON.isFavorite
        }
    }
#endif
    
    func getAll() async throws -> [CandidateDTO] {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        guard let url = URL(string: "http://localhost:8080/candidate") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .GET,
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (data, _) = try await urlSession.data(for: request)
        let candidate = try JSONDecoder().decode([NetworkCandidate].self,
                                                 from: data)
        
        return candidate.map { $0.toDomain() }
    }
    
    func get(candidateId: String) async throws -> CandidateDTO {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        guard let url = URL(string: "http://localhost:8080/candidate/\(candidateId)") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .GET,
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (data, _) = try await urlSession.data(for: request)
        let candidate = try JSONDecoder().decode(NetworkCandidate.self,
                                                 from: data)
        
        return candidate.toDomain()
    }
    
    func update(candidate: CandidateDTO) async throws -> CandidateDTO {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        guard let url = URL(string: "http://localhost:8080/candidate/\(candidate.id)") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .PUT,
            parameters: [
                "email": candidate.email,
                "note": candidate.note ?? "",
                "linkedinURL": candidate.linkedinURL ?? "",
                "firstName": candidate.firstName,
                "lastName": candidate.lastName,
                "phone": candidate.phone
            ],
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (data, _) = try await urlSession.data(for: request)
        let candidate = try JSONDecoder().decode(NetworkCandidate.self,
                                                 from: data)
        
        return candidate.toDomain()
    }
    
    func delete(candidateId: UUID) async throws {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        guard let url = URL(string: "http://localhost:8080/candidate/\(candidateId)") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .DELETE,
            parameters: [:],
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (_, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return
        }
        
        if httpResponse.statusCode != 200 {
            throw CandidateServiceError.candidateNotDeleted
        }
    }
    
    func updateFavorite(candidate: CandidateDTO) async throws {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        guard let url = URL(string: "http://localhost:8080/candidate/\(candidate.id)/favorite") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .PUT,
            parameters: [:],
            headers: ["Authorization" : "Bearer \(authenticationToken)"])
        
        let (data, _) = try await urlSession.data(for: request)
        let _ = try JSONDecoder().decode(NetworkCandidate.self,
                                         from: data)
    }
}
