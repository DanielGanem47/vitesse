//
//  NetworkAuthenticationServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

struct NetworkAuthenticationServiceTests {
    init() {
        MockURLProtocol.payloadToReturn = nil
        MockURLProtocol.errorToReturn = nil
    }
    
    @Test func authenticate() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let payload = ["token" : "zaezaresqdfgrdqgrghdfsfhtfs",
                       "isAdmin" : true]
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationServiceTests(urlSession: urlSession)
        
        let result = try await service.authenticate(email: "admin@vitesse.com",
                                                    password: "test123")
        #expect (result == true)
    }
    
    @Test func authenticateFailed() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let payload = []
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationServiceTests(urlSession: urlSession)
        
        let result = try await service.authenticate(email: "",
                                                    password: "")
        #expect (result == false)
    }
    
    @Test func login() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let payload = ["token" : "zaezaresqdfgrdqgrghdfsfhtfs",
                       "isAdmin" : true]
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationServiceTests(urlSession: urlSession)
        
        let result = try await service.login(email: "admin@vitesse.com",
                                             password: "test123")
        #expect (result == true)
    }
    
    @Test func loginFailed() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let payload = []
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkAuthenticationServiceTests(urlSession: urlSession)
        
        let result = try await service.login(email: "",
                                             password: "")
        #expect (result == false)
    }
}
