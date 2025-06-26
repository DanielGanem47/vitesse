//
//  Candidate.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class Candidate: Codable, Identifiable {
    var id: UUID
    var name: String
    var phoneNumber: String
    var email: String
    var linkedInUrl: String
    var Note: String
    var isFavorite: Bool
    
    init(id: UUID, name: String, phoneNumber: String, email: String, linkedInUrl: String, Note: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.linkedInUrl = linkedInUrl
        self.Note = Note
        self.isFavorite = isFavorite
    }
}

class Candidates: ObservableObject {
    @Published private(set) var list: [Candidate] = [Candidate(id: UUID(), name: "Daniel G.", phoneNumber: "06 37 93 62 65", email: "daniel.ganem@icloud.com", linkedInUrl: "www.linkedin.com", Note: "tres bon eleve", isFavorite: true)]
}
