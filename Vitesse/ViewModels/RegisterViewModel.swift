//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var loginViewModel: LoginViewModel = LoginViewModel()

    private let executeDataRequestRegisterUser: (URLRequest) async throws -> (Data, URLResponse)

    init(
        executeDataRequestRegisterUser: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)
    ) {
        self.executeDataRequestRegisterUser = executeDataRequestRegisterUser
    }

    // MARK: Register
    func sendUserToServer() async throws -> Bool {
        print("sendUserToServer")
        guard let url = URL(string: "http://localhost:8080/user/register") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: String = """
        {
            "email": \(loginViewModel.authenticatedUser.email)
            "password": \(loginViewModel.authenticatedUser.password)
            "firstName": \(loginViewModel.authenticatedUser.firstName)
            "lastName": \(loginViewModel.authenticatedUser.lastName)
        }
        """
        request.httpBody = body.data(using: .utf8)

        let (_, response) = try await executeDataRequestRegisterUser(request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 201
    }
}
