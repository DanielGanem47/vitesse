import Foundation

enum UserRepositoryError {
    case unknown
    case badURL
}

final class UserRepository {
    private let userService: NetworkUserService

    // MARK: - Initializers
    init(userService: NetworkUserService = NetworkUserService()) {
        self.userService = userService
    }

    // MARK: - Functions
    func createUser(user: UserDTO) async throws -> Bool {
        return try await userService.createUser(user: user)
    }
}
