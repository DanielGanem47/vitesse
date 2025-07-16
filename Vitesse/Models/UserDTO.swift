//
//  User.swift
//  Vitesse
//
//  Created by daniel ganem on 23/06/2025.
//

import Foundation

class UserDTO: ObservableObject, Codable, Identifiable {
    @Published var id: UUID
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var password: String
    @Published var confirmedPassword: String
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, email, password, confirmedPassword
    }
    
    init(id: UUID, firstName: String, lastName: String, email: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.confirmedPassword = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        confirmedPassword = try container.decode(String.self, forKey: .confirmedPassword)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(confirmedPassword, forKey: .confirmedPassword)
    }
    
    func reset() {
        id = UUID()
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        confirmedPassword = ""
    }
}
