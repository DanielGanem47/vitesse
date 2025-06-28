//
//  CandidatesList.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidatesList: View {

    @Environment(\.editMode)
    private var editMode

    @ObservedObject var candidates: Candidates = Candidates()

    var body: some View {
        VStack {
            CandidateListToolbar()

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
            }
        }
        .navigationTitle("Candidats")
        .toolbar {
            EditButton()
        }
    }
}

#if DEBUG

#Preview {
    NavigationView {
        CandidatesList()
    }
}

#endif
