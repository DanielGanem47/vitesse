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

        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 201,
            httpVersion: nil,
            headerFields: nil
        )!
        client?.urlProtocol(self, didReceive: response,
                            cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
}
