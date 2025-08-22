//
//  Candidate.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

class CandidateDTO: Identifiable, Codable {
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
    
    var isFavorite: Bool
    var isSelected: Bool
    
    // MARK: - Initializers
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
}
