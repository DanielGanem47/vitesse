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

    func getAll() async throws -> [CandidateDTO] {
        guard let authenticationToken = authenticationManager.authenticationToken else {
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
        throw CandidateServiceError.notImplemented
    }

    func update(candidate: CandidateDTO) async throws -> CandidateDTO {
        throw CandidateServiceError.notImplemented
    }

    func delete(candidate: CandidateDTO) async throws {
        throw CandidateServiceError.notImplemented
    }
}
