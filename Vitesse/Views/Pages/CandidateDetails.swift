//
//  CandidateDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateDetails: View {
    var candidate: CandidateDTO
    
    @Environment(\.editMode)
    private var editMode

    init(candidate: CandidateDTO) {
        self.candidate = candidate
    }
    
    var body: some View {
            HStack {
                CandidateDetailsForm(candidate: candidate)
            }
            .toolbar {
                EditButton()
            }
    }
}

#Preview {
    CandidateDetails(candidate: CandidateDTO(id: UUID(), name: "Daniel G.", phoneNumber: "06 37 93 62 65", email: "daniel.ganem@icloud.com", linkedInUrl: "www.linkedin.com", note: "tres bon eleve", isFavorite: true))
}
