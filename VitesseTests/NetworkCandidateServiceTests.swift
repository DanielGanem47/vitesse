//
//  NetworkCandidateServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 11/08/2025.
//

import Testing
import Foundation

@Suite
struct NetworkCandidateServiceTests {
    init() {
        MockURLProtocol.payloadToReturn = nil
        MockURLProtocol.errorToReturn = nil
    }

    @Test
    func shouldReturnPayload() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let candidateService = TestCandidateService()
        
        let payload = [NetworkCandidate(id: UUID(),
                                        firstName: "",
                                        lastName: "",
                                        phone: "",
                                        email: "",
                                        linkedin_url: "",
                                        note: "",
                                        isFavorite: false)]
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let candidates = try await candidateService.getAll()
        
        #expect(candidates.count == 6)
    }
}
