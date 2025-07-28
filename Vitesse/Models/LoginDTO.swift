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

struct TokenAdminDTO: Codable {
    var token: String?
    var isAdmin: Bool
}
