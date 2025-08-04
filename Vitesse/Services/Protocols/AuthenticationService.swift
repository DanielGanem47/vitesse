//
//  AuthenticationService.swift
//  Vitesse
//
//  Created by daniel ganem on 04/08/2025.
//

protocol AuthenticationService {
    var authenticationManager: AuthenticationManager { get }

    func authenticate(email: String, password: String) async throws -> Bool
    func login(email: String, password: String) async -> Bool
}

