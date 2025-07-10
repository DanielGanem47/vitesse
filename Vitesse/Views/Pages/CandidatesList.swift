//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    @ObservedObject var candidates: Candidates = Candidates(list: [
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
    ])

    @Environment(\.editMode) var editMode: Binding<EditMode>?

    @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(candidates.list) { candidate in
                    if editMode?.wrappedValue.isEditing == true {
                        CandidateListRow(candidate: candidate)
                    } else {
                        NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                            CandidateListRow(candidate: candidate)
                        }
                    }
                }
            }
            .toolbar {
                CandidateListToolbar()
            }
            .navigationTitle("Candidates")
        }
    }
}

#Preview("Default mode") {
    CandidatesList()
}
