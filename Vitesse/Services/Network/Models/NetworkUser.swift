//
//  NetworkUser.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

class NetworkUser {
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    
    init(id: UUID, firstName: String, lastName: String, email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    // MARK: Functions
    func reset() {
        id = UUID()
        firstName = ""
        lastName = ""
        email = ""
        password = ""
    }
}
