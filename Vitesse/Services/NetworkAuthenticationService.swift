import Foundation

protocol AuthenticationService {
    func authenticate(email: String, password: String) async throws
}

struct NetworkAuthenticationService: AuthenticationService {

    private let authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    func authenticate(email: String, password: String) async throws {
        guard let url = URL(string: "http://localhost:8080/user/auth") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .POST,
            parameters: [
                "email": email,
                "password": password
            ]
        )

        let (data, _) = try await URLSession.shared.data(for: request)

        let tokenResponse = try JSONDecoder().decode(TokenAdminDTO.self, from: data)

        authenticationManager.updateAuthenticationToken(tokenResponse.token)
    }
}
