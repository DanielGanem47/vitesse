//
//  AuthenticationRepositoryTests.swift
//  Vitesse
//
//  Created by daniel ganem on 15/08/2025.
//

import Foundation
import SwiftUI

final class AuthenticationRepositoryTests: TestAuthenticationService, ObservableObject {
    @ObservedObject var authenticationManager: AuthenticationManager
    
    @Environment(\.dependenciesContainer) private var dependenciesContainer
    @Published var isLogged: Bool = false

    private let service: any AuthenticationService

    init(service: any AuthenticationService = TestAuthenticationService()) {
        self.service = service
        if let observableService = service as? TestAuthenticationService {
            observableService.authenticationManager.$isLogged
                .receive(on: RunLoop.main)
                .assign(to: &$isLogged)
        }
    }

    // MARK: - Functions
    func authenticate(email: String, password: String) async throws -> Bool {
        return try await service.authenticate(email: email,
                                              password: password)
    }
    
    func login(email: String, password: String) async throws -> Bool {
        let result = try await service.login(email: email,
                                             password: password)
        isLogged = result
        return result
    }

    func isLoggedOut() {
        isLogged = false
        service.authenticationManager.isLogged = false
    }

    func isAdmin() -> Bool {
        return service.authenticationManager.tokenAdmin.isAdmin
    }
    
    func getTokenAdmin() -> TokenAdminDTO {
        return service.authenticationManager.tokenAdmin
    }
    
    func getConnectedUser() -> UserDTO {
        return service.authenticationManager.authenticatedUser
    }
    
    func setNewEmail(email: String) {
        service.authenticationManager.authenticatedUser.email = email
    }
    
    func setNewPassword(password: String) {
        service.authenticationManager.authenticatedUser.password = password
    }
}
