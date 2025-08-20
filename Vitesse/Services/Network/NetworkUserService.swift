import Foundation

struct NetworkUserService: UserService {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func createUser(user: UserDTO) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/user/register") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .POST,
            parameters: ["email": user.email,
                         "password": user.password,
                         "firstName": user.firstName,
                         "lastName": user.lastName])

        let (_, response) = try await urlSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 201
    }
}
