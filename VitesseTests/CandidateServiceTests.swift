//
//  CandidateServiceTests.swift
//  VitesseTests
//
//  Created by daniel ganem on 04/08/2025.
//

import Testing
import SwiftUI
@testable import Vitesse

struct CandidateServiceTests {

    // MARK: - Constants

    private let dependenciesContainer = TestDependenciesContainer()



    // MARK: - Tests

    @Test func getAll() async throws {

        var configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]


        let networkSession = URLSession(configuration: configuration)


        let candidates = try await dependenciesContainer.candidateService.getAll()
        #expect(candidates.count == 6)
    }

    @Test(arguments: ["1"]) func get(id: String) async throws {
        let candidate = try await dependenciesContainer.candidateService.get(candidateId: id)
        #expect(candidate.firstName == "Daniel 1")
    }
}

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

        let networkCandidateService = NetworkCandidateService(urlSession: urlSession)

        let payload = [
            NetworkCandidate(id: UUID(), firstName: "", lastName: "", phone: "", email: "", linkedinURL: "", note: "")
        ]

        MockURLProtocol.payloadToReturn = try JSONEncoder().encode(payload)

        let candidates = try await networkCandidateService.getAll()

        #expect(candidates.count == 6)
    }
}

final class MockURLProtocol: URLProtocol {

    static var payloadToReturn: Data?
    static var errorToReturn: Error?

    override func startLoading() {
        if let errorToReturn = Self.errorToReturn {
            client?.urlProtocolDidFinishLoading(self)
            client?.urlProtocol(self, didFailWithError: errorToReturn)
            return
        }

        guard let data = Self.payloadToReturn else {
            fatalError("No payload provided")
        }

        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
}
