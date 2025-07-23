//
//  Candidate.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class CandidateDTO: ObservableObject, Codable, Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    var linkedinURL: String?
    var note: String?
    
    var displayedName: String {
        return "\(firstName) \(lastName.first?.uppercased() ?? "")."
    }
    
    @Published var isFavorite: Bool
    @Published var isSelected: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, phone, email, linkedinURL, note, isFavorite
    }
    
    init(id: UUID, firstName: String, lastName: String, phone: String, email: String, linkedin_url: String, note: String, isFavorite: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.linkedinURL = linkedin_url
        self.note = note
        self.isFavorite = isFavorite
        self.isSelected = false
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
        isSelected = false
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

class Candidates: ObservableObject {
    @Published var list: [CandidateDTO] = []
    
    init(list: [CandidateDTO]) {
        self.list = list
    }
}
