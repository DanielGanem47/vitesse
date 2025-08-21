//
//  NetworkAuthenticationServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

@testable import Vitesse

@Suite(.serialized)
struct NetworkAuthenticationServiceTests {

    private var urlSession: URLSession

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        urlSession = URLSession(configuration: configuration)

        MockURLProtocol.payloadToReturn = nil
        MockURLProtocol.errorToReturn = nil
    }

    @Test func authenticate() async throws {
        let payload = TokenAdminDTO(token: "FfdfsdfdF9fdsf.fdsfdf98FDkzfdA3122.J83TqjxRzmuDuruBChNT8sMg5tfRi5iQ6tUlqJb3M9U", isAdmin: true)

        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationService(urlSession: urlSession)
        
        let result = try await service.authenticate(email: "admin@vitesse.com",
                                                    password: "test123")
        #expect (result == true)
    }
    
    @Test func authenticateFailed() async throws {
        let payload = [""]
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationService(urlSession: urlSession)

        let result = try await service.authenticate(email: "", password: "")

        #expect (result == false)
    }
    
    @Test func login() async throws {
        let payload = TokenAdminDTO(token: "FfdfsdfdF9fdsf.fdsfdf98FDkzfdA3122.J83TqjxRzmuDuruBChNT8sMg5tfRi5iQ6tUlqJb3M9U", isAdmin: true)

        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationService(urlSession: urlSession)
        
        let result = try await service.login(email: "admin@vitesse.com", password: "test123")

        #expect (result == true)
    }
    
    @Test func loginFailed() async throws {
        let payload = [""]
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationService(urlSession: urlSession)
        
        let result = try await service.login(email: "", password: "")

        #expect (result == false)
    }
}
