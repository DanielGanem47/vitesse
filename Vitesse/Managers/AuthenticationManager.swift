import Foundation
import SwiftUI

final class AuthenticationManager {
    static let shared = AuthenticationManager()

    var login = LoginDTO(email: "",
                         password: "")
    var tokenAdmin = TokenAdminDTO(token: "",
                                   isAdmin: false)
    @State var isLogged = false
    @ObservedObject var authenticatedUser: UserDTO = UserDTO(id: UUID(),
                                                             firstName: "",
                                                             lastName: "",
                                                             email: "admin@vitesse.com",
                                                             password: "test123")
    var loginError: String? = nil
    
    func updateAuthenticatedToken(_ token: TokenAdminDTO) {
        tokenAdmin = token
    }
}
