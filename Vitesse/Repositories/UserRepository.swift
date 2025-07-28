enum UserRepositoryError {
    case unknown
}

final class UserRepository {
    private let userService: NetworkUserService

    // MARK: - Initializers

    init(userService: NetworkUserService = NetworkUserService()) {
        self.userService = userService
    }

    // MARK: - Functions

}
