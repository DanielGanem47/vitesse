//
//  SpyAuthenticationRepository.swift
//  VitesseTests
//
//  Created by daniel ganem on 22/08/2025.
//

import Foundation
@testable import Vitesse

class SpyAuthenticationRepository: AuthenticationRepository {
    var hasCalledLogin: Bool = false
    var hasCalledIsLoggedOut: Bool = false
    var hasCalledIsAdmin: Bool = false
    var hasCalledGetTokenAdmin: Bool = false
    var hasCalledGetConnectedUser: Bool = false
    var hasCalledSetNewEmail: Bool = false
    var hassCalledSetNewPassword: Bool = false
    
    override func login(email: String, password: String) async throws -> Bool {
        hasCalledLogin = true
        return hasCalledLogin
    }
    
    override func isLoggedOut() {
        hasCalledIsLoggedOut = true
    }
    
    override func isAdmin() -> Bool {
        hasCalledIsAdmin = true
        return hasCalledIsAdmin
    }
    
    override func getTokenAdmin() -> TokenAdminDTO {
        hasCalledGetTokenAdmin = true
        return TokenAdminDTO(token: "",
                             isAdmin: true)
    }
    
    override func getConnectedUser() -> UserDTO {
        hasCalledGetConnectedUser = true
        return UserDTO(id: UUID(),
                       firstName: "",
                       lastName: "",
                       email: "",
                       password: "")
    }
    
    override func setNewEmail(email: String) {
        hasCalledSetNewEmail = true
    }
    
    override func setNewPassword(password: String) {
        hassCalledSetNewPassword = true
    }
}
