import Foundation
import SwiftUI

final class AuthenticationManager : ObservableObject {
    @Published var isLogged: Bool = false

    static let shared = AuthenticationManager()
    var login = LoginDTO(email: "",
                         password: "")
    var tokenAdmin = TokenAdminDTO(token: "",
                                   isAdmin: false)
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
}
