//
//  NetworkCandidate.swift
//  Vitesse
//
//  Created by daniel ganem on 11/08/2025.
//

import Foundation

class NetworkCandidate: Identifiable, Codable {
    var id: UUID
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    var linkedinURL: String?
    var note: String?
    var isFavorite: Bool
    
    init(id: UUID, firstName: String, lastName: String, phone: String, email: String, linkedin_url: String, note: String, isFavorite: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.linkedinURL = linkedin_url
        self.note = note
        self.isFavorite = isFavorite
    }
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, phone, email, linkedinURL, note, isFavorite
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        phone = try container.decode(String.self, forKey: .phone)
        email = try container.decode(String.self, forKey: .email)
        linkedinURL = try container.decodeIfPresent(String.self, forKey: .linkedinURL)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(phone, forKey: .phone)
        try container.encode(email, forKey: .email)
        try container.encode(linkedinURL, forKey: .linkedinURL)
        try container.encode(note, forKey: .note)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
}
