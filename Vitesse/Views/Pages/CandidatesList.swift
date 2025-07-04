//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    var candidates: Candidates = Candidates(list: [CandidateDTO(
        id: UUID(),
        name: "Daniel G.",
        phoneNumber: "06 37 93 62 65",
        email: "daniel.ganem@icloud.com",
        linkedInUrl: "www.linkedin.com",
        note: "tres bon eleve",
        isFavorite: true
    )])

    @Environment(\.editMode)
    private var editMode

    @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if editMode?.wrappedValue == .active {
                    List {
                        ForEach(candidates.list) { candidate in
                            CandidateListRow(candidate: candidate)
                        }
                    }
                    .navigationTitle("Candidates")
                } else {
                    List {
                        ForEach(candidates.list) { candidate in
                            NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                                CandidateListRow(candidate: candidate)
                            }
                        }
                    }
                    .navigationTitle("Candidates")
                }
            }
            .toolbar {
                CandidateListToolbar()
            }
        }
    }
}

#Preview("Default mode") {
    CandidatesList()
}
