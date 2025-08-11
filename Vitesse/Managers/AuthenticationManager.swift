import Foundation
import SwiftUI

final class AuthenticationManager : ObservableObject {
    static let shared = AuthenticationManager()

    var login = LoginDTO(email: "",
                         password: "")
    var tokenAdmin = TokenAdminDTO(token: "",
                                   isAdmin: false)
    @Published var isLogged = false
    var authenticatedUser: UserDTO = UserDTO(id: UUID(),
                                             firstName: "",
                                             lastName: "",
                                             email: "admin@vitesse.com",
                                             password: "test123")
    var loginError: String? = nil
    
    // MARK: Login
    func updateAuthenticatedToken(_ token: TokenAdminDTO) async {
        tokenAdmin = token
    }
    
    func updateIsLoggedAndError(_ logged: Bool, _ error: String?) async {
        isLogged = logged
        loginError = error
    }
}
