//
//  NetworkLogin.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

final class NetworkLogin {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    // MARK: Functions
    func toDomain() -> LoginDTO {
        LoginDTO(email: email,
                 password: password)
    }
}

final class NetworkTokenAdmin {
    var token: String?
    var isAdmin: Bool
    
    init(token: String?, isAdmin: Bool) {
        self.token = token
        self.isAdmin = isAdmin
    }

    // MARK: Functions
    func toDomain() -> TokenAdminDTO {
        TokenAdminDTO(token: token,
                      isAdmin: isAdmin)
    }
}
