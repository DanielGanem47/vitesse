import Foundation
import SwiftUI

class TestAuthenticationService: AuthenticationService, ObservableObject {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    // MARK: Login
    internal func authenticate(email: String, password: String) async throws -> Bool {
        return true
    }
    
    func login(email: String, password: String) async -> Bool {
        authenticationManager.isLogged = true
        authenticationManager.loginError = nil
        return true
    }
}
