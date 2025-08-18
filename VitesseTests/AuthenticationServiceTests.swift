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

    @Test(arguments: "", "") func authenticate(email: String, password: String) -> Bool {
        let result = authenticate(email: email,
                                  password: password)
        #expect (result == false)
    }
    
    @Test func login() async throws {
        let result = try await testDependenciesContainer.authenticationRepository.login(email: "",
                                                                                        password: "")
        #expect (result == true)
    }
}
