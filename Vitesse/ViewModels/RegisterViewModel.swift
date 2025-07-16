//
//  RegisterViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class RegisterViewModel: ObservableObject {
    private let executeDataRequestRegisterUser: (URLRequest) async throws -> (Data, URLResponse)

    init(
        executeDataRequestRegisterUser: @escaping (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)
    ) {
        self.executeDataRequestRegisterUser = executeDataRequestRegisterUser
    }

    // MARK: Register
    func createUser(user: UserDTO) async throws -> Bool {
        guard let url = URL(string: "http://localhost:8080/user/register") else {
            throw URLError(.badURL)
        }

        let request = try URLRequest(
            url: url,
            method: .POST,
            parameters: [
                "email": user.email,
                "password": user.password,
                "firstName": user.firstName,
                "lastName": user.lastName,
            ]
        )

        let (_, response) = try await executeDataRequestRegisterUser(request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        return httpResponse.statusCode == 201
    }
}
