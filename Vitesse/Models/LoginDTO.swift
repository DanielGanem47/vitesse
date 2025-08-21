//
//  LoginDTO.swift
//  Vitesse
//
//  Created by daniel ganem on 27/06/2025.
//

import Foundation

struct LoginDTO: Codable {
    var email: String
    var password: String
}

public struct TokenAdminDTO: Codable {
    public var token: String?
    public var isAdmin: Bool

    // MARK: - Initializers

    public init(token: String? = nil, isAdmin: Bool) {
        self.token = token
        self.isAdmin = isAdmin
    }
}
