//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    @ObservedObject var candidates: Candidates = Candidates(list: [CandidateDTO(
        id: UUID(),
        name: "Daniel G.",
        phoneNumber: "06 37 93 62 65",
        email: "daniel.ganem@icloud.com",
        linkedInUrl: "www.linkedin.com",
        Note: "tres bon eleve",
        isFavorite: true
    )])

    var body: some View {
        @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()
        
        NavigationView{
            VStack {
                Form {
                    List {
                        ForEach(candidates.list) { candidate in
                            NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                                CandidateListRow(candidate: candidate)
                            }
                        }
                        .onDelete { element in
                            print("DELETE")
                        }
                    }
                    .navigationTitle("Candidats")
                    .toolbar {
                        CandidateListToolbar()
                    }
                }
            }
        }
    }
}

#Preview("Default mode") {
    CandidatesList()
}
