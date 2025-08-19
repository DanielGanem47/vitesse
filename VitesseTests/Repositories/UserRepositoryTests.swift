//
//  UserRepositoryTests.swift
//  Vitesse
//
//  Created by daniel ganem on 15/08/2025.
//

import Foundation

final class UserRepositoryTests: TestUserService, ObservableObject {
    private let service: any UserService
    
    init(service: any UserService = TestUserService()) {
        self.service = service
    }
    
    // MARK: - Functions
    func createUser(user: UserDTO) async throws -> Bool {
        return try await service.createUser(user: user)
    }
}
