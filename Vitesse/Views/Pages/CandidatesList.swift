//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    let candidates: [CandidateDTO] = [
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: true),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: true),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: false),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: false),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: false),
        CandidateDTO(id: UUID(),
                     name: "Daniel G.",
                     phoneNumber: "06 37 93 62 65",
                     email: "daniel.ganem@icloud.com",
                     linkedInUrl: "www.linkedin.com",
                     note: "tres bon eleve",
                     isFavorite: true)
    ]

    @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()

    @State
    private var isEditing = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(candidates) { candidate in
                    if isEditing {
                        CandidateListRow(candidate: candidate, isEditing: true)
                    } else {
                        NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                            CandidateListRow(candidate: candidate, isEditing: false)
                        }
                    }
                }
            }
            .toolbar {
                CandidateListToolbar(isEditing: $isEditing)
            }
            .navigationTitle("Candidates")
        }
    }
}

#Preview("Default mode") {
    CandidatesList()
        .environment(\.editMode, .constant(.active))
}
