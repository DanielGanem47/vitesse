//
//  AuthenticationServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

@Suite
struct AuthenticationServiceTests {
    private var service = TestAuthenticationService()

    @Test(arguments: ["admin@vitesse.com"], ["test123"]) func authenticate(email: String, password: String) async throws {
        let result = try await service.authenticate(email: email,
                                                    password: password)
        #expect (result == true)
    }
    
    @Test func login() async throws {
        let result = await service.login(email: "",
                                         password: "")
        #expect (result == true)
    }
}
