//
//  CandidateRow.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListRow: View {
    let candidate: CandidateDTO
    @State var selected: Bool

    init(candidate: CandidateDTO) {
        self.candidate = candidate
        self.selected = false
    }
    
    @Environment(\.editMode)
    private var editMode

    var body: some View {
        HStack {
            if editMode?.wrappedValue == .active {
                Button("",
                       systemImage: selected ? "circle.fill" : "circle") {
                    // Faire qqc
                    selected.toggle()
                }
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
        candidate: CandidateDTO(
            id: UUID(),
            name: "Daniel G.",
            phoneNumber: "06 37 93 62 65",
            email: "daniel.ganem@icloud.com",
            linkedInUrl: "www.linkedin.com",
            note: "tres bon eleve",
            isFavorite: true
        )
    )
}

#Preview("Edit mode") {
    CandidateListRow(
        candidate: CandidateDTO(
            id: UUID(),
            name: "Daniel G.",
            phoneNumber: "06 37 93 62 65",
            email: "daniel.ganem@icloud.com",
            linkedInUrl: "www.linkedin.com",
            note: "tres bon eleve",
            isFavorite: true
        )
    )
    .environment(\.editMode, .constant(.active))
}
