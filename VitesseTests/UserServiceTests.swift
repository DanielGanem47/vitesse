//
//  UserServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI
@testable import Vitesse

struct UserServiceTests {
    private var testDependenciesContainer = TestDependenciesContainer()

    @Test func createUser() async throws {
        let result = try await testDependenciesContainer.userRepository.createUser(user: UserDTO(id: UUID(),
                                                                                                 firstName: "",
                                                                                                 lastName: "",
                                                                                                 email: "",
                                                                                                 password: ""))
        #expect (result == true)
    }

}
