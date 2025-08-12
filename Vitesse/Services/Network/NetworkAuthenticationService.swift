import Foundation
import SwiftUI

class NetworkAuthenticationService: AuthenticationService, ObservableObject {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    // MARK: Login
    func authenticate(email: String, password: String) async throws -> Bool {
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
        
        return true
    }

    func login(email: String, password: String) async {
        do {
            let _ = try await authenticate(email: email,
                                           password: password)

            await authenticationManager.updateIsLoggedAndError(true,
                                                               nil)
        } catch {
            await authenticationManager.updateIsLoggedAndError(false,
                                                               "Erreur de connexion: \(error.localizedDescription)")
        }
    }
}
