//
//  AuthenticationServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

struct AuthenticationServiceTests {
    private var testDependenciesContainer = TestDependenciesContainer()

    @Test func login() async throws {
        let result = try await testDependenciesContainer.authenticationRepository.login(email: "",
                                                                                        password: "")
        #expect (result == true)
    }
}
