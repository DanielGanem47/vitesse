//
//  CandidateRow.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListRow: View {
    @Environment(\.dependenciesContainer) private var dependenciesContainer

    var candidate: NetworkCandidate
    private let isEditing: Bool
    
    @ObservedObject var candidatesViewModel: CandidatesViewModel
    @State var isSelected = false

    init(candidate: NetworkCandidate, isEditing: Bool, candidatesViewModel: CandidatesViewModel) {
        self.candidate = candidate
        self.isEditing = isEditing
        self.candidatesViewModel = candidatesViewModel
    }
    
    var body: some View {
        HStack {
            if isEditing {
                Button("",
                       systemImage: isSelected ? "checkmark.circle" : "circle") {
                    isSelected.toggle()
                    candidatesViewModel.selectCandidate(candidateId: candidate.id,
                                                        isSelected: isSelected)
                }
            }
            
            Text(candidatesViewModel.getDisplayedNameFor(networkCandidate: candidate))
                .frame(alignment: .leading)
            
            Spacer()

            if !isEditing {
                Image(systemName: candidate.isFavorite ? "star.fill" : "star")
            }
        }
        .padding()
    }
}

#Preview("Default mode") {
    var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()
    CandidateListRow(candidate: NetworkCandidate(id: UUID(),
                                                 firstName: "Daniel 1",
                                                 lastName: "Ganem",
                                                 phone: "06 37 93 62 65",
                                                 email: "daniel.ganem@icloud.com",
                                                 linkedin_url: "www.linkedin.com",
                                                 note: "tres bon eleve",
                                                 isFavorite: true),
                     isEditing: false,
                     candidatesViewModel: candidatesViewModel)
}

#Preview("Edit mode") {
    var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()
    CandidateListRow(candidate: NetworkCandidate(id: UUID(),
                                                 firstName: "Daniel 1",
                                                 lastName: "Ganem",
                                                 phone: "06 37 93 62 65",
                                                 email: "daniel.ganem@icloud.com",
                                                 linkedin_url: "www.linkedin.com",
                                                 note: "tres bon eleve",
                                                 isFavorite: true),
                     isEditing: true,
                     candidatesViewModel: candidatesViewModel)
}
