//
//  NetworkLogin.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

struct NetworkLogin {
    var email: String
    var password: String
}

extension NetworkLogin {
    func toDomain() -> LoginDTO {
        LoginDTO(email: email,
                 password: password)
    }
}

struct NetworkTokenAdmin {
    var token: String?
    var isAdmin: Bool
}
