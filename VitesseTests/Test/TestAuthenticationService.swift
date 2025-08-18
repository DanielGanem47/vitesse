import Foundation
import SwiftUI

class TestAuthenticationService: AuthenticationService, ObservableObject {
    var authenticationManager: AuthenticationManager

    init(authenticationManager: AuthenticationManager = .shared) {
        self.authenticationManager = authenticationManager
    }

    // MARK: Login
    func login(email: String, password: String) async -> Bool {
        await authenticationManager.updateIsLoggedAndError(true,
                                                           nil)
        
        return true
    }
}
