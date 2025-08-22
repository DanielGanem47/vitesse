//
//  User.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import Foundation

class UserDTO: Codable, Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    
    // MARK: - Initializers
    init(id: UUID, firstName: String, lastName: String, email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
}
