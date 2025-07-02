//
//  CandidateDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateDetails: View {
    let candidate: CandidateDTO
    
    var body: some View {
        CandidateDetailsForm(candidate: candidate)
    }
}

#Preview {
    CandidateDetails(candidate: CandidateDTO(id: UUID(), name: "Daniel G.", phoneNumber: "06 37 93 62 65", email: "daniel.ganem@icloud.com", linkedInUrl: "www.linkedin.com", note: "tres bon eleve", isFavorite: true))
}
