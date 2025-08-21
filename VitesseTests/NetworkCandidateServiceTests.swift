//
//  NetworkCandidateServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 11/08/2025.
//

import Testing
import Foundation

struct NetworkCandidateServiceTests {
    private let authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        MockURLProtocol.payloadToReturn = nil
        MockURLProtocol.errorToReturn = nil
        self.authenticationManager = authenticationManager
    }

    @Test func getAll() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let service = NetworkCandidateService(urlSession: urlSession)
        
        let candidates = try await service.getAll()
        #expect(candidates.count == 1)
    }
    
    @Test func get() async throws {
        guard let authenticationToken = authenticationManager.tokenAdmin.token else {
            throw CandidateServiceError.notAuthenticated
        }
        
       let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let service = NetworkCandidateService(urlSession: urlSession)
        
        let candidate = try await service.get(candidateId: "1")
        #expect(candidate.firstName == "Daniel 1")
    }
    
    @Test func update() async throws {
       let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let payload = ["email": "daniel.ganem@icloud.com",
                       "note": "tres bon eleve",
                       "linkedinURL": "www.linkedin.com",
                       "firstName": "Daniel 1",
                       "lastName": "Ganem",
                       "phone": "06 37 93 62 65"]
        
        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)
        
        let service = NetworkCandidateService(urlSession: urlSession)
        
        let result = try await service.update(candidate: CandidateDTO(id: UUID(),
                                                                      firstName: "Daniel 1",
                                                                      lastName: "Ganem",
                                                                      phone: "06 37 93 62 65",
                                                                      email: "daniel.ganem@icloud.com",
                                                                      linkedin_url: "www.linkedin.com",
                                                                      note: "tres bon eleve",
                                                                      isFavorite: true))
        #expect(result.firstName == "Daniel 1")
    }
    
    @Test func delete() async throws {
       let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let service = NetworkCandidateService(urlSession: urlSession)
        
        try await service.delete(candidateId: UUID())
    }
    
    @Test func updateFavorite() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        
        let service = NetworkCandidateService(urlSession: urlSession)
        
        try await service.updateFavorite(candidate: CandidateDTO(id: UUID(),
                                                                 firstName: "Daniel 1",
                                                                 lastName: "Ganem",
                                                                 phone: "06 37 93 62 65",
                                                                 email: "daniel.ganem@icloud.com",
                                                                 linkedin_url: "www.linkedin.com",
                                                                 note: "tres bon eleve",
                                                                 isFavorite: true))
    }
}
