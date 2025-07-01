//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {
    var body: some View {
        @ObservedObject var candidatesViewModel: CandidatesViewModel = CandidatesViewModel()

        NavigationView{
            VStack {
                List{
                    ForEach(candidatesViewModel.list) { candidate in
                        NavigationLink(destination: CandidateDetails(candidate: candidate)) {
                            CandidateListRow(candidate: candidate)
                        }
                    }
                    .onDelete { indexSet in
                    }
                }
                .toolbar(content: {
                    CandidateListToolbar()
                })
                .navigationTitle("Candidats")
            }
        }
    }
}

#Preview {
    CandidatesList()
}
