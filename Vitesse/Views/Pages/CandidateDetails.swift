//
//  CandidateDetails.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateDetails: View {
    var candidate: CandidateDTO
    var candidatesViewModel: CandidatesViewModel
    
    init(candidate: CandidateDTO, candidatesViewModel: CandidatesViewModel) {
        self.candidate = candidate
        self.candidatesViewModel = candidatesViewModel
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
    var viewModel: CandidatesViewModel = CandidatesViewModel()
    CandidateDetails(candidate: CandidateDTO(id: UUID(),
                                             firstName: "Daniel 1",
                                             lastName: "Ganem",
                                             phone: "06 37 93 62 65",
                                             email: "daniel.ganem@icloud.com",
                                             linkedin_url: "www.linkedin.com",
                                             note: "tres bon eleve",
                                             isFavorite: true),
                     candidatesViewModel: viewModel)
}
