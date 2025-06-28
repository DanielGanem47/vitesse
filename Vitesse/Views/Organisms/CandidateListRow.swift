//
//  CandidateRow.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListRow: View {

    let candidate: Candidate

    @Environment(\.editMode)
    private var editMode

    var body: some View {
        HStack {
            if editMode?.wrappedValue == .active {
                Image(systemName: "circle")
            }

            Text(candidate.name)
                .frame(alignment: .leading)
            Spacer()
            Image(systemName: candidate.isFavorite ? "star.fill" : "star")
                .frame(alignment: .trailing)
        }
        .padding()
    }
}

#Preview("Default mode") {
    CandidateListRow(
        candidate: Candidate(
            id: "1",
            name: "Daniel G.",
            phoneNumber: "06 37 93 62 65",
            email: "daniel.ganem@icloud.com",
            linkedInUrl: "www.linkedin.com",
            Note: "tres bon eleve",
            isFavorite: true
        )
    )
}

#Preview("Editing mode") {
    CandidateListRow(
        candidate: Candidate(
            id: "1",
            name: "Daniel G.",
            phoneNumber: "06 37 93 62 65",
            email: "daniel.ganem@icloud.com",
            linkedInUrl: "www.linkedin.com",
            Note: "tres bon eleve",
            isFavorite: true
        )
    )
    .environment(\.editMode, .constant(.active))
}
