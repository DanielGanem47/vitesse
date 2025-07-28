import Foundation

enum CandidateServiceError: Error {
    case notImplemented
    case notAuthenticated
}

struct NetworkCandidateService {
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

            let (data, _) = try await URLSession.shared.data(for: request)

            let JSON = try JSONDecoder().decode(CandidateDTO.self,
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
            parameters: nil,
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode([CandidateDTO].self, from: data)
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
            parameters: nil,
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(CandidateDTO.self, from: data)
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
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let candidate = try JSONDecoder().decode(CandidateDTO.self,
                                                 from: data)
        
        return candidate
    }
    
    func delete(candidate: CandidateDTO) async throws -> Bool {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
        guard let url = URL(string: "http://localhost:8080/candidate") else {
            throw URLError(.badURL)
        }
        
        let request = try URLRequest(
            url: url,
            method: .DELETE,
            parameters: [
                "CandidateId": candidate.id
            ],
            headers: ["Authorization" : "Bearer \(authenticationToken)"]
        )
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 200
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
            parameters: nil,
            headers: ["Authorization" : "Bearer \(authenticationToken)"])
        
        let (data, _) = try await URLSession.shared.data(for: request)

        let _ = try JSONDecoder().decode(CandidateDTO.self,
                                         from: data)
    }
}
