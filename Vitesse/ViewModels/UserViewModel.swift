//
//  UserViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

class UserViewModel {
    var tokenAdmin: TokenAdminDTO = TokenAdminDTO(token: "", isAdmin: false)
    var connectedUser: NetworkUser = NetworkUser(id: UUID(),
                                                 firstName: "",
                                                 lastName: "",
                                                 email: "",
                                                 password: "",
                                                 confirmedPassword: "")
    
    // MARK: Functions
    func setConnectedUser(user: NetworkUser) {
        connectedUser = user
    }
    
    func isAdmin() -> Bool {
        return tokenAdmin.isAdmin
    }
}
