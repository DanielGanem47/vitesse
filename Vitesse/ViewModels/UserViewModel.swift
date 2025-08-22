//
//  UserViewModel.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

class UserViewModel: ObservableObject {
    private var dependenciesContainer: any CustomDependenciesContainer
    var tokenAdmin: TokenAdminDTO = TokenAdminDTO(token: "",
                                                  isAdmin: false)
    var connectedUser: UserDTO = UserDTO(id: UUID(),
                                         firstName: "",
                                         lastName: "",
                                         email: "",
                                         password: "")
    
    init(dependenciesContainer: any CustomDependenciesContainer) {
        self.dependenciesContainer = dependenciesContainer
    }

    // MARK: Functions
    func setConnectedUser(user: UserDTO) {
        connectedUser = user
    }
    
    func isAdmin() -> Bool {
        return tokenAdmin.isAdmin
    }
}
