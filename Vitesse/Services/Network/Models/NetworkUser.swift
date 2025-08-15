//
//  NetworkUser.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

final class NetworkUser {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var confirmedPassword: String
    
    init(id: UUID, firstName: String, lastName: String, email: String, password: String, confirmedPassword: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.confirmedPassword = confirmedPassword
    }
    
    // MARK: Functions
    func reset() {
        id = UUID()
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        confirmedPassword = ""
    }
    
    func toDomain() -> UserDTO {
        return UserDTO(id: id,
                       firstName: firstName,
                       lastName: lastName,
                       email: email,
                       password: password)
    }
}
