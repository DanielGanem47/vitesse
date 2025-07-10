//
//  CandidateRow.swift
//  Vitesse
//
//  Created by daniel ganem on 26/06/2025.
//

import SwiftUI

struct CandidateListRow: View {
    @ObservedObject var candidate: CandidateDTO

    @Environment(\.editMode) var editMode: Binding<EditMode>?

    init(candidate: CandidateDTO) {
        self.candidate = candidate
    }
    
    var body: some View {
        HStack {
            if editMode?.wrappedValue.isEditing == true {
                Button("",
                       systemImage: candidate.isSelected ? "checkmark.circle" : "circle") {
                    candidate.isSelected.toggle()
                }
            }
            
            Text(candidate.name)
                .frame(alignment: .leading)
            
            Spacer()
            
            Button("",
                   systemImage: candidate.isFavorite ? "star.fill" : "star") {
                candidate.isFavorite.toggle()
            }
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

