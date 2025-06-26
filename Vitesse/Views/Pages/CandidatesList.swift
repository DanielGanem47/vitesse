//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    var body: some View {
        @ObservedObject var candidates: Candidates = Candidates()

        NavigationView{
            VStack {
                CandidateListToolbar()
                List(candidates.list) { candidate in
                    NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                        CandidateListRow(candidate: candidate)
                    }
                }
                .navigationTitle("Candidats")
            }
        }
    }
}

#Preview {
    CandidatesList()
}
