final class AuthenticationManager {

    static let shared = AuthenticationManager()

    private(set) var authenticationToken: String?

    private init() {}

    func updateAuthenticationToken(_ token: String) {
        authenticationToken = token
    }
}
