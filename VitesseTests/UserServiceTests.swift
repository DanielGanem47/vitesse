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
    @Environment(\.testDependenciesContainer) private var testDependenciesContainer

    @Test func createUser() async throws {
        let result = try await testDependenciesContainer.userService.createUser(user: Vitesse.UserDTO(id: UUID(),
                                                                                                      firstName: "",
                                                                                                      lastName: "",
                                                                                                      email: "",
                                                                                                      password: ""))
        #expect (result == true)
    }

}
