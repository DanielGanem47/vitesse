//
//  AuthenticationServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI
@testable import Vitesse

struct AuthenticationServiceTests {
    private var testDependenciesContainer = TestDependenciesContainer()

    @Test func login() async throws {
        let result = try await testDependenciesContainer.authenticationService.login(email: "",
                                                                                     password: "")
        #expect (result == true)
    }
}
