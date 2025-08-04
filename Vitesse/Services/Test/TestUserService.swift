import Foundation

struct TestUserService: UserService {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    func createUser(user: UserDTO) async throws -> Bool {
        return true
    }
}
