import Foundation
import SwiftUI

protocol AuthenticationService {
    var authenticationManager: AuthenticationManager { get }

    func authenticate(email: String, password: String) async throws
    func login(email: String, password: String) async
}

class NetworkAuthenticationService: AuthenticationService, ObservableObject {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    // MARK: Login
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

        await authenticationManager.updateAuthenticatedToken(tokenResponse)
    }

    func login(email: String, password: String) async {
        do {
            try await authenticate(email: email,
                                   password: password)

            await authenticationManager.updateIsLoggedAndError(true,
                                                               nil)
        } catch {
            await authenticationManager.updateIsLoggedAndError(false,
                                                               "Erreur de connexion: \(error.localizedDescription)")
        }
    }
}
