//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {

    let candidates: [CandidateDTO] = [CandidateDTO(
        id: UUID(),
        name: "Daniel G.",
        phoneNumber: "06 37 93 62 65",
        email: "daniel.ganem@icloud.com",
        linkedInUrl: "www.linkedin.com",
        note: "tres bon eleve",
        isFavorite: true
    )]

    @Environment(\.editMode)
    private var editMode

    var body: some View {
        List {
            ForEach(candidates) { candidate in
                if editMode?.wrappedValue == .active {
                    CandidateListRow(candidate: candidate)
                } else {
                    NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                        CandidateListRow(candidate: candidate)
                    }
                }

            }
        }
        .navigationTitle("Candidats")
        .toolbar {
            CandidateListToolbar()
        }
    }
}

#Preview("Default mode") {
    var loginViewModel: LoginViewModel = LoginViewModel()
    CandidatesList(loginViewModel: loginViewModel)
}
