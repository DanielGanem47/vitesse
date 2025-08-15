//
//  AuthenticationRepository.swift
//  Vitesse
//
//  Created by daniel ganem on 15/08/2025.
//

import Foundation

final class AuthenticationRepository {
    private let service: any AuthenticationService

    init(service: any AuthenticationService = NetworkAuthenticationService()) {
        self.service = service
    }

    // MARK: - Functions
    func isLogged () -> Bool {
        return service.authenticationManager.isLogged
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
    
    func login(email: String, password: String) async throws -> Bool {
        do {
            return try await service.authenticate(email: email,
                                                  password: password)
        } catch {
            // TODO: Handle error
            return false
        }
    }
}
