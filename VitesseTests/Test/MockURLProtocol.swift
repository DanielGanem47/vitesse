//
//  MockURLProtocol.swift
//  VitesseTests
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

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
