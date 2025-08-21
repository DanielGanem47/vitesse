import Foundation
import SwiftUI

enum NetworkAuthenticationServiceError: Error {
    case invalidResponse
}

class NetworkAuthenticationService: AuthenticationService, ObservableObject {
    var authenticationManager: AuthenticationManager
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared, authenticationManager: AuthenticationManager = .shared) {
        self.urlSession = urlSession
        self.authenticationManager = authenticationManager
    }

    // MARK: Login
    func authenticate(email: String, password: String) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/user/auth") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(url: url,
                                     method: .POST,
                                     parameters: ["email": email,
                                                  "password": password])

        do {
            let (data, _) = try await urlSession.data(for: request)

            let tokenResponse = try JSONDecoder().decode(TokenAdminDTO.self, from: data)

            await authenticationManager.updateAuthenticatedToken(tokenResponse)

            return true
        } catch {
            return false
        }
    }

    func login(email: String, password: String) async throws -> Bool {
        do {
            let authenticationResult = try await authenticate(email: email,
                                           password: password)

            guard authenticationResult else {
                return false
            }

            authenticationManager.isLogged = true
            authenticationManager.loginError = nil
            return true
        } catch {
            authenticationManager.isLogged = false
            authenticationManager.loginError = "Erreur de connexion: \(error.localizedDescription)"
            return false
        }
    }
}
