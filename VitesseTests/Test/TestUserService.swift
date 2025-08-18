import Foundation

struct TestUserService: UserService {
    func createUser(user: UserDTO) async throws -> Bool {
        return true
    }
}
