import Foundation
import SwiftUI

class TestAuthenticationService: AuthenticationService, ObservableObject {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    // MARK: Login
    func authenticate(email: String, password: String) async throws -> Bool {
        await authenticationManager.updateAuthenticatedToken(TokenAdminDTO(token:"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFkbWluQHZpdGVzc2UuY29tIiwiaXNBZG1pbiI6dHJ1ZX0.66y2jHqt-w3dQgc-W9sHMBhDN7BIHOq8X7IL3H--NzY",
                                                                           isAdmin: true))
        
        return true
    }

    func login(email: String, password: String) async -> Bool {
        await authenticationManager.updateIsLoggedAndError(true,
                                                           nil)
        
        return true
    }
}
