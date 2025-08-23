//
//  NetworkUserServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

@testable import Vitesse

@Suite
struct NetworkUserServiceTests {
    private var urlSession: URLSession

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        urlSession = URLSession(configuration: configuration)

        MockURLProtocol.payloadToReturn = nil
        MockURLProtocol.errorToReturn = nil
    }

    @Test func createUser() async throws {
        let payload = UserDTO(id: UUID(),
                              firstName: "",
                              lastName: "",
                              email: "",
                              password: "")
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkUserService(urlSession: urlSession)
        
        let result = try await service.createUser(user: UserDTO(id: UUID(),
                                                                firstName: "",
                                                                lastName: "",
                                                                email: "",
                                                                password: ""))
        #expect (result == true)
    }

}
