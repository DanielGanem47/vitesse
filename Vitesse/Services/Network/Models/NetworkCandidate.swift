//
//  NetworkCandidate.swift
//  Vitesse
//
//  Created by Damien Rivet on 07/08/2025.
//

import Foundation

struct NetworkCandidate: Codable {
    var id: UUID
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    var linkedinURL: String?
    var note: String?
}

extension NetworkCandidate {

    func toDomain() -> CandidateDTO {
        CandidateDTO(
            id: id,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            email: email,
            linkedin_url: linkedinURL ?? "",
            note: note ?? "",
            isFavorite: false
        )
    }
}
