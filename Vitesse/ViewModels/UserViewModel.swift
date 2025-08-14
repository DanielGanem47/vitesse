//
//  UserViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

class UserViewModel: ObservableObject {
    var tokenAdmin: TokenAdminDTO = TokenAdminDTO(token: "",
                                                  isAdmin: false)
    var connectedUser: UserDTO = UserDTO(id: UUID(),
                                         firstName: "",
                                         lastName: "",
                                         email: "",
                                         password: "")
    
    // MARK: Functions
    func setConnectedUser(user: UserDTO) {
        connectedUser = user
    }
    
    func isAdmin() -> Bool {
        return tokenAdmin.isAdmin
    }
}
