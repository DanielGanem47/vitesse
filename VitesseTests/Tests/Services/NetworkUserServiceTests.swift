//
//  NetworkUserServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI

@testable import Vitesse

@Suite(.serialized)
struct NetworkUserServiceTests {
    init() {
        MockURLProtocol.payloadToReturn = nil
        MockURLProtocol.errorToReturn = nil
    }

    @Test func createUser() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let payload = ["email": "",
                       "password": "",
                       "firstName": "",
                       "lastName": ""]
        
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
