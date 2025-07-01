//
//  Candidate.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import Foundation

struct CandidateDTO: Codable, Identifiable {
    var id: UUID
    var name: String
    var phoneNumber: String
    var email: String
    var linkedInUrl: String
    var Note: String
    var isFavorite: Bool
}
