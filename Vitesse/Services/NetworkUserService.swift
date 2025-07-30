import Foundation

protocol UserService {
    var authenticationManager: AuthenticationManager { get }
    
    func createUser(user: UserDTO) async throws -> Bool
}

struct NetworkUserService: UserService {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    func createUser(user: UserDTO) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/user/auth") else {
            throw URLError(.badURL)
        }

        let request = try await URLRequest(
            url: url,
            method: .POST,
            parameters: [
                "email": authenticationManager.login.email,
                "password": authenticationManager.login.password
            ]
        )

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let tokenResponse = try JSONDecoder().decode(TokenAdminDTO.self, from: data)
            
            await authenticationManager.updateAuthenticatedToken(tokenResponse)
            
            return true
        } catch {
            return false
        }
    }
}
